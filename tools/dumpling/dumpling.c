/*
 * Copyright (C) 2015 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/capability.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <unistd.h>

#include <cutils/properties.h>

#include "private/android_filesystem_config.h"

#define LOG_TAG "dumpling"
#include <cutils/log.h>

#include "dumpling.h"

/* read before root is shed */
static char cmdline_buf[16384] = "(unknown)";

static void dump_dev_files(const char *title, const char *driverpath, const char *filename) {
    DIR *d;
    struct dirent *de;
    char path[PATH_MAX];

    d = opendir(driverpath);
    if (d == NULL) {
        return;
    }

    while ((de = readdir(d))) {
        if (de->d_type != DT_LNK) {
            continue;
        }
        snprintf(path, sizeof(path), "%s/%s/%s", driverpath, de->d_name, filename);
        dump_file(title, path);
    }

    closedir(d);
}

/* dumps the current system state to stdout */
static void dumpling() {
    time_t now = time(NULL);
    char date[80];
    char build[PROPERTY_VALUE_MAX], fingerprint[PROPERTY_VALUE_MAX];
    char radio[PROPERTY_VALUE_MAX], bootloader[PROPERTY_VALUE_MAX];
    char build_type[PROPERTY_VALUE_MAX];

    property_get("ro.build.display.id", build, "(unknown)");
    property_get("ro.build.fingerprint", fingerprint, "(unknown)");
    property_get("ro.build.type", build_type, "(unknown)");
    property_get("ro.baseband", radio, "(unknown)");
    property_get("ro.bootloader", bootloader, "(unknown)");
    strftime(date, sizeof(date), "%Y-%m-%d %H:%M:%S", localtime(&now));

    printf("========================================================\n");
    printf("== dumpstate: %s\n", date);
    printf("========================================================\n");

    printf("\n");
    printf("Build: %s\n", build);
    printf("Build fingerprint: '%s'\n", fingerprint); /* format is important for other tools */
    printf("Bootloader: %s\n", bootloader);
    printf("Radio: %s\n", radio);

    printf("Kernel: ");
    dump_file(NULL, "/proc/version");
    printf("Command line: %s\n", strtok(cmdline_buf, "\n"));
    printf("\n");

    dump_dev_files("TRUSTY VERSION", "/sys/bus/platform/drivers/", "trusty_version");

    run_command("UPTIME", 10, "uptime", NULL);
    dump_file("MMC PERF", "/sys/block/mmcblk0/stat");
    dump_file("MMC PERF", "/sys/block/mmcblk1/stat");
    dump_file("MEMORY INFO", "/proc/meminfo");
    run_command("CPU INFO", 10, "top", "-n", "1", "-d", "1", NULL);
    run_command("PROCRANK", 20, "procrank", NULL);
    dump_file("VIRTUAL MEMORY STATS", "/proc/vmstat");
    dump_file("VMALLOC INFO", "/proc/vmallocinfo");
    dump_file("ZONEINFO", "/proc/zoneinfo");
    dump_file("SWAPS", "/proc/swaps");
    dump_file("IOPORTS", "/proc/ioports");
    dump_file("INPUTDEVICES", "/proc/bus/input/devices");
    dump_file("INPUTHNADLERS", "/proc/bus/input/handlers");
    dump_file("CPUINFO", "/proc/cpuinfo");
    dump_file("LIMITS", "/proc/self/limits");
    dump_file("RTCDRIVER", "/proc/driver/rtc");
    dump_file("RTCDRIVER", "/proc/driver/rtc");
    dump_file("PAGETYPEINFO", "/proc/pagetypeinfo");
    dump_file("BUDDYINFO", "/proc/buddyinfo");
    dump_file("KERNEL CPUFREQ", "/sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state");

    run_command("PROCESSES AND THREADS", 10, "ps", "-Tl", NULL);
    run_command("PROCESSES (SELINUX)", 10, "ps", "-Z", NULL);

    run_command("LIST OF OPEN FILES", 10, "lsof", NULL);
    // for_each_pid(do_showmap, "SMAPS OF ALL PROCESSES");
    for_each_tid(show_wchan, "BLOCKED PROCESS WAIT-CHANNELS");

    printf("\n");
    dump_file("INTERRUPTS", "/proc/interrupts");

    printf("\n");
    print_properties();

    printf("\n");
    run_command("FILESYSTEMS & FREE SPACE", 10, "df", "-m", "-a", "-P", NULL);

    run_command("LAST RADIO LOG", 10, "parse_radio_log", "/proc/last_radio_log", NULL);

    printf("ec656c00 WLEDBacklight brightness=");
    dump_file(NULL, "/sys/devices/leds-qpnp-ec656c00/leds/wled:backlight/brightness");
    printf("ec656c00 WLED Backlight brightness=");
    dump_file(NULL, "/sys/devices/leds-qpnp-ec656c00/leds/wled:backlight/max_brightness");

    printf("mdss_fb_primary.152 LCD Backlight brightness=");
    dump_file(NULL, "./sys/devices/fd900000.qcom,mdss_mdp/qcom,mdss_fb_primary.152/leds/lcd-backlight/brightness");
    printf("mdss_fb_primary.152 LCD Backlight brightness=");
    dump_file(NULL, "./sys/devices/fd900000.qcom,mdss_mdp/qcom,mdss_fb_primary.152/leds/lcd-backlight/max_brightness");

    printf("LGE_TOUCH/platform_data=");
    dump_file(NULL, "/sys/devices/virtual/input/lge_touch/platform_data");

    dump_file("Power Management Stats", "/proc/msm_pm_stats");

    run_command("Block List", 5, "ls", "-lRp", "/dev/block/", NULL);
    run_command("Filesystem List", 5, "ls", "-lRp", "/proc/fs/", NULL);
    dump_file("Mount List", "/proc/mounts");
    dump_file("TWRP Last Install", "/cache/recovery/last_install");
    dump_file("TWRP Log", "/cache/recovery/log");
    dump_file("TWRP Last Log", "/cache/recovery/last_log");
    dump_file("TWRP Last Last Log", "/cache/recovery/last_log.1");

    run_command("DEFCONFIG", 20, "gunzip", "-c", "/proc/config.gz", NULL);
    
    printf("\n");
    do_dmesg();

    printf("\n");
    dump_file("LAST KMSG", "/proc/last_kmsg");
    printf("\n");
    dump_file("LAST KMSG DONTPANIC YO", "/data/dontpanic/last_kmsg*");
    
    printf("\n");
    printf("========================================================\n");
    printf("== dumpling: done\n");
    printf("========================================================\n");
}

static void sigpipe_handler(int n) {
    // don't complain to stderr or stdout
    _exit(EXIT_FAILURE);
}

static void vibrate(FILE* vibrator, int ms) {
    fprintf(vibrator, "%d\n", ms);
    fflush(vibrator);
}

int main(int argc, char *argv[]) {
    struct sigaction sigact;
    int do_add_date = 0;
    int do_compress = 0;
    int do_vibrate = 1;
    char* use_outfile = 0;
    int use_socket = 0;
    int do_fb = 0;

    ALOGI("begin\n");

    /* clear SIGPIPE handler */
    memset(&sigact, 0, sizeof(sigact));
    sigact.sa_handler = sigpipe_handler;
    sigaction(SIGPIPE, &sigact, NULL);

    /* set as high priority, and protect from OOM killer */
    setpriority(PRIO_PROCESS, 0, -20);
    FILE *oom_adj = fopen("/proc/self/oom_score_adj", "w");
    if (oom_adj) {
        fputs("-17", oom_adj);
        fclose(oom_adj);
    }

    /* open the vibrator before dropping root */
    FILE *vibrator = 0;
    if (do_vibrate) {
        vibrator = fopen("/sys/class/timed_output/vibrator/enable", "w");
        if (vibrator) {
            fcntl(fileno(vibrator), F_SETFD, FD_CLOEXEC);
            vibrate(vibrator, 150);
        }
    }

    /* read /proc/cmdline before dropping root */
    FILE *cmdline = fopen("/proc/cmdline", "r");
    if (cmdline != NULL) {
        fgets(cmdline_buf, sizeof(cmdline_buf), cmdline);
        fclose(cmdline);
    }

    /* ensure we will keep capabilities when we drop root */
    if (prctl(PR_SET_KEEPCAPS, 1) < 0) {
        ALOGE("prctl(PR_SET_KEEPCAPS) failed: %s\n", strerror(errno));
        return -1;
    }

    struct __user_cap_header_struct capheader;
    struct __user_cap_data_struct capdata[2];
    memset(&capheader, 0, sizeof(capheader));
    memset(&capdata, 0, sizeof(capdata));
    capheader.version = _LINUX_CAPABILITY_VERSION_3;
    capheader.pid = 0;

    capdata[CAP_TO_INDEX(CAP_SYSLOG)].permitted = CAP_TO_MASK(CAP_SYSLOG);
    capdata[CAP_TO_INDEX(CAP_SYSLOG)].effective = CAP_TO_MASK(CAP_SYSLOG);
    capdata[0].inheritable = 0;
    capdata[1].inheritable = 0;

    if (capset(&capheader, &capdata[0]) < 0) {
        ALOGE("capset failed: %s\n", strerror(errno));
        return -1;
    }

    dumpling();

    /* done */
    if (vibrator) {
        for (int i = 0; i < 3; i++) {
            vibrate(vibrator, 75);
            usleep((75 + 50) * 1000);
        }
        fclose(vibrator);
    }

    ALOGI("done\n");

    return 0;
}
