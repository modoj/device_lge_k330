#!/system/bin/sh

enable=`getprop persist.service.crash.enable`

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

case $enable in
    "1")
        echo 1 > /sys/module/msm_poweroff/parameters/download_mode
        echo 63 > /sys/module/msm_rtb/parameters/filter
        echo 1024 > /sys/kernel/debug/tracing/buffer_size_kb
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
        echo 1 > /sys/kernel/debug/tracing/events/irq/irq_handler_entry/enable
        echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_start/enable
        echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_end/enable
        ;;
    "0")
        echo 0 > /sys/module/msm_poweroff/parameters/download_mode
        echo 0 > /sys/module/msm_rtb/parameters/filter
        echo 7 > /sys/kernel/debug/tracing/buffer_size_kb
        # free buffer for saving memory
        echo > /sys/kernel/debug/tracing/free_buffer
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
        echo 0 > /sys/kernel/debug/tracing/events/irq/irq_handler_entry/enable
        echo 0 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_start/enable
        echo 0 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_end/enable
        ;;
esac
