# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.19

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /snap/clion/152/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /snap/clion/152/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ruben/CLionProjects/lab2_BST_students

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/Lab2Students.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/Lab2Students.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Lab2Students.dir/flags.make

CMakeFiles/Lab2Students.dir/src/main.c.o: CMakeFiles/Lab2Students.dir/flags.make
CMakeFiles/Lab2Students.dir/src/main.c.o: ../src/main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/Lab2Students.dir/src/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Lab2Students.dir/src/main.c.o -c /home/ruben/CLionProjects/lab2_BST_students/src/main.c

CMakeFiles/Lab2Students.dir/src/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Lab2Students.dir/src/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ruben/CLionProjects/lab2_BST_students/src/main.c > CMakeFiles/Lab2Students.dir/src/main.c.i

CMakeFiles/Lab2Students.dir/src/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Lab2Students.dir/src/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ruben/CLionProjects/lab2_BST_students/src/main.c -o CMakeFiles/Lab2Students.dir/src/main.c.s

CMakeFiles/Lab2Students.dir/src/tree.c.o: CMakeFiles/Lab2Students.dir/flags.make
CMakeFiles/Lab2Students.dir/src/tree.c.o: ../src/tree.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/Lab2Students.dir/src/tree.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Lab2Students.dir/src/tree.c.o -c /home/ruben/CLionProjects/lab2_BST_students/src/tree.c

CMakeFiles/Lab2Students.dir/src/tree.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Lab2Students.dir/src/tree.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ruben/CLionProjects/lab2_BST_students/src/tree.c > CMakeFiles/Lab2Students.dir/src/tree.c.i

CMakeFiles/Lab2Students.dir/src/tree.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Lab2Students.dir/src/tree.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ruben/CLionProjects/lab2_BST_students/src/tree.c -o CMakeFiles/Lab2Students.dir/src/tree.c.s

CMakeFiles/Lab2Students.dir/src/utils.c.o: CMakeFiles/Lab2Students.dir/flags.make
CMakeFiles/Lab2Students.dir/src/utils.c.o: ../src/utils.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/Lab2Students.dir/src/utils.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Lab2Students.dir/src/utils.c.o -c /home/ruben/CLionProjects/lab2_BST_students/src/utils.c

CMakeFiles/Lab2Students.dir/src/utils.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Lab2Students.dir/src/utils.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ruben/CLionProjects/lab2_BST_students/src/utils.c > CMakeFiles/Lab2Students.dir/src/utils.c.i

CMakeFiles/Lab2Students.dir/src/utils.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Lab2Students.dir/src/utils.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ruben/CLionProjects/lab2_BST_students/src/utils.c -o CMakeFiles/Lab2Students.dir/src/utils.c.s

CMakeFiles/Lab2Students.dir/src/generate_candidates.c.o: CMakeFiles/Lab2Students.dir/flags.make
CMakeFiles/Lab2Students.dir/src/generate_candidates.c.o: ../src/generate_candidates.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/Lab2Students.dir/src/generate_candidates.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/Lab2Students.dir/src/generate_candidates.c.o -c /home/ruben/CLionProjects/lab2_BST_students/src/generate_candidates.c

CMakeFiles/Lab2Students.dir/src/generate_candidates.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/Lab2Students.dir/src/generate_candidates.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ruben/CLionProjects/lab2_BST_students/src/generate_candidates.c > CMakeFiles/Lab2Students.dir/src/generate_candidates.c.i

CMakeFiles/Lab2Students.dir/src/generate_candidates.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/Lab2Students.dir/src/generate_candidates.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ruben/CLionProjects/lab2_BST_students/src/generate_candidates.c -o CMakeFiles/Lab2Students.dir/src/generate_candidates.c.s

# Object files for target Lab2Students
Lab2Students_OBJECTS = \
"CMakeFiles/Lab2Students.dir/src/main.c.o" \
"CMakeFiles/Lab2Students.dir/src/tree.c.o" \
"CMakeFiles/Lab2Students.dir/src/utils.c.o" \
"CMakeFiles/Lab2Students.dir/src/generate_candidates.c.o"

# External object files for target Lab2Students
Lab2Students_EXTERNAL_OBJECTS =

Lab2Students: CMakeFiles/Lab2Students.dir/src/main.c.o
Lab2Students: CMakeFiles/Lab2Students.dir/src/tree.c.o
Lab2Students: CMakeFiles/Lab2Students.dir/src/utils.c.o
Lab2Students: CMakeFiles/Lab2Students.dir/src/generate_candidates.c.o
Lab2Students: CMakeFiles/Lab2Students.dir/build.make
Lab2Students: CMakeFiles/Lab2Students.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable Lab2Students"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Lab2Students.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Lab2Students.dir/build: Lab2Students

.PHONY : CMakeFiles/Lab2Students.dir/build

CMakeFiles/Lab2Students.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Lab2Students.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Lab2Students.dir/clean

CMakeFiles/Lab2Students.dir/depend:
	cd /home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ruben/CLionProjects/lab2_BST_students /home/ruben/CLionProjects/lab2_BST_students /home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug /home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug /home/ruben/CLionProjects/lab2_BST_students/cmake-build-debug/CMakeFiles/Lab2Students.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/Lab2Students.dir/depend

