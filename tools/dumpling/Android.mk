LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := dumpling
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/sbin

LOCAL_SRC_FILES := dumpling.c utils.c

LOCAL_STATIC_LIBRARIES := libc libcutils liblog libselinux

LOCAL_CFLAGS += -Wall -Wno-unused-parameter -std=gnu99

LOCAL_FORCE_STATIC_EXECUTABLE := true

include $(BUILD_EXECUTABLE)
