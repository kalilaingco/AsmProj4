;Program name: "Assignment 4".  This program normalizes a random amount of numbers, sorts it, and displays it
;  Copyright (C) 2024  Kalila Ingco                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;This program was created by: Kalila Ingco
;CWID: 884713140
;Student email: Kalila@csu.fullerton.edu
;Date: 11/2/2024
;Section: CPSC 240-17
;This is for educational purposes 
;Program has been created and tested on a Linux Ubuntu device
; The files needed are show_Array.asm, executive.asm, r.sh, Sort.c, fill_random_array.asm, normalize_array.asm, main.c, and isnan.asm
; commands to run program is: ./r.sh

global isnan 

segment .data

pi dq 3.14

segment .bss

segment .text

isnan:
push        rbp
mov         rbp, rsp
push        rbx
push        rcx
push        rdx
push        rdi
push        rsi
push        r8
push        r9
push        r10
push        r11
push        r12
push        r13
push        r14
push        r15
pushf 


movsd   xmm15, xmm0     ;save number from fill_random_array 
movsd   xmm14, qword[pi]

;check parity of number 
ucomisd     xmm15, xmm14    ;if returns a 1, then number is a NaN and will jump to yesNan
jp     yesNan
jmp     noNan 

yesNan:
mov     rax, 1      ;return 1 to fill_random_array
jmp     exit

noNan:
mov     rax, 0      ;return 0 to fill_random_array
jmp exit




exit: 
;restore GPRs
popf
pop         r15
pop         r14
pop         r13
pop         r12
pop         r11
pop         r10
pop         r9
pop         r8
pop         rsi
pop         rdi
pop         rdx
pop         rcx
pop         rbx
pop         rbp
ret

