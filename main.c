/*Program name: "Assignment 4".  This program normalizes a random amount of numbers, sorts it, and displays it
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
*/


#include<stdio.h>
#include<stdlib.h>
#include<string.h>

extern char* executive();

int main(){
    printf("Welcome to Random Products, LLC. \n");
    printf("This software is maintained by Kalila Ingco\n");
    char* name = executive();
    printf("Oh, %s. We hope you enjoyed your arrays. Do come again. \n", name);
    printf("A zero will be returned to the operating system. Have a nice day \n");
    return 0;
}

