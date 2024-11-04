#Program name: "Assignment 4".  This program normalizes a random amount of numbers, sorts it, and displays it
#;  Copyright (C) 2024  Kalila Ingco                                                                           *
#;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
#;version 3 as published by the Free Software Foundation.                                                                    *
#;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
#;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
#;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
#;****************************************************************************************************************************




#;This program was created by: Kalila Ingco
#;CWID: 884713140
#;Student email: Kalila@csu.fullerton.edu
#;Date: 11/2/2024
#;Section: CPSC 240-17
#;This is for educational purposes 
#;Program has been created and tested on a Linux Ubuntu device
#; The files needed are show_Array.asm, executive.asm, r.sh, Sort.c, fill_random_array.asm, normalize_array.asm, main.c, and isnan.asm
#; commands to run program is: ./r.sh
#*/


#remove old files 
rm *.o

#assemble the asm files
nasm -f elf64 -l executive.lis -o executive.o executive.asm

nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm

nasm -f elf64 -l normalize_array.lis  -o normalize_array.o normalize_array.asm

nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

#assemble the c file 
gcc -c -Wall -m64 -fno-pie -no-pie -o main.o  main.c -std=c17
#gcc is compiler for C, c17 is standard 

#assemble the c file 
gcc -c -m64 -Wall -fno-pie -no-pie -o Sort.o Sort.c -std=c17

#link all files together 
gcc -m64 -no-pie -std=c17 -o go.out executive.o fill_random_array.o isnan.o normalize_array.o show_array.o main.o Sort.o -Wall #-fno-pie -no-pie


#run the program 
./go.out