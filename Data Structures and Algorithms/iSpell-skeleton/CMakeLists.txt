cmake_minimum_required(VERSION 3.14)
project(iSpell C)

set(CMAKE_C_STANDARD 11)

include_directories(include)

add_executable(iSpell
        include/hash_table.h
        include/linked_list.h
        include/utils.h
        src/hash_table.c
        src/linked_list.c
        src/main.c
        src/utils.c
        include/generate_candidates.h src/generate_candidates.c)
