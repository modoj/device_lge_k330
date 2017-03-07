#!/system/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`
factory=`getprop ro.factorytest`

#Enable adaptive LMK and set vmpressure_file_min
echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 53059 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min

# HMP scheduler settings for 8909 similiar to 8916
echo 3 > /proc/sys/kernel/sched_window_stats_policy
echo 3 > /proc/sys/kernel/sched_ravg_hist_size

# HMP Task packing settings for 8909 similiar to 8916
echo 20 > /proc/sys/kernel/sched_small_task
echo 30 > /proc/sys/kernel/sched_mostly_idle_load
echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run

# disable thermal core_control to update scaling_min_freq
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo 1 > /sys/devices/system/cpu/cpu0/online
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
# enable thermal core_control now
echo 1 > /sys/module/msm_thermal/core_control/enabled

echo "30000 1094400:50000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo 998400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
echo "1 800000:85 998400:90 1094400:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

# Bring up all cores online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

if [ "1" != "$factory" ]; then
	# Enable core control
	insmod /system/lib/modules/core_ctl.ko
	echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	max_freq=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
	min_freq=800000
	echo $((min_freq*100 / max_freq)) $((min_freq*100 / max_freq)) $((66*1000000 / max_freq)) \
		$((55*1000000 / max_freq)) > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
	echo $((33*1000000 / max_freq)) > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
fi


# Apply governor settings for 8909
for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
do
	echo "bw_hwmon" > $devfreq_gov
	for cpu_bimc_bw_step in /sys/class/devfreq/qcom,cpubw*/bw_hwmon/bw_step
	do
		echo 60 > $cpu_bimc_bw_step
	done
	for cpu_guard_band_mbps in /sys/class/devfreq/qcom,cpubw*/bw_hwmon/guard_band_mbps
	do
		echo 30 > $cpu_guard_band_mbps
	done
done

for gpu_bimc_io_percent in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/io_percent
do
	echo 40 > $gpu_bimc_io_percent
done
for gpu_bimc_bw_step in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/bw_step
do
	echo 60 > $gpu_bimc_bw_step
done
for gpu_bimc_guard_band_mbps in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/guard_band_mbps
do
	echo 30 > $gpu_bimc_guard_band_mbps
done


chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy

emmc_boot=`getprop ro.boot.emmc`
case "$emmc_boot"
    in "true")
        chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

# Post-setup services
start perfd
# start mpdecision

# Create native cgroup and move all tasks to it. Allot 15% real-time# bandwidth limit to native cgroup (which is what remains after
# Android uses up 80% real-time bandwidth limit). root cgroup should
# become empty after all tasks are moved to native cgroup.

CGROUP_ROOT=/dev/cpuctl
mkdir $CGROUP_ROOT/native
echo 150000 > $CGROUP_ROOT/native/cpu.rt_runtime_us

# We could be racing with task creation, as a result of which its possible that
# we may fail to move all tasks from root cgroup to native cgroup in one shot.
# Retry few times before giving up.
for loop_count in 1 2 3
do
	for i in $(cat $CGROUP_ROOT/tasks)
	do
		echo $i > $CGROUP_ROOT/native/tasks
	done

	root_tasks=$(cat $CGROUP_ROOT/tasks)
	if [ -z "$root_tasks" ]
	then
		break
	fi
done

# Check if we failed to move all tasks from root cgroup
if [ ! -z "$root_tasks" ]
then
	echo "Error: Could not move all tasks to native cgroup"
fi
