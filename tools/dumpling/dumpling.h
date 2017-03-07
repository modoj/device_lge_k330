/*
 * Copyright (C) 2008 The Android Open Source Project
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

#ifndef _DUMPLING_H_
#define _DUMPLING_H_

#include <time.h>
#include <unistd.h>
#include <stdbool.h>
#include <stdio.h>


typedef void (for_each_pid_func)(int, const char *);
typedef void (for_each_tid_func)(int, int, const char *);

/* prints the contents of a file */
int dump_file(const char *title, const char *path);

/* prints the contents of the fd */
int dump_file_from_fd(const char *title, const char *path, int fd);

/* forks a command and waits for it to finish -- terminate args with NULL */
int run_command(const char *title, int timeout_seconds, const char *command, ...);

/* prints all the system properties */
void print_properties();

/* for each process in the system, run the specified function */
void for_each_pid(for_each_pid_func func, const char *header);

/* for each thread in the system, run the specified function */
void for_each_tid(for_each_tid_func func, const char *header);

/* Displays a blocked processes in-kernel wait channel */
void show_wchan(int pid, int tid, const char *name);

/* Gets the dmesg output for the kernel */
void do_dmesg();

#endif /* _DUMPLING_H_ */
