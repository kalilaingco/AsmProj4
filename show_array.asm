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


global show_array
extern printf

segment .data
    hexform db "0x%016lx      %18.13g", 10, 0

segment .bss
align 64
storedata resb 1024

segment .text

show_array:
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

;save all floating-point numbers
mov     rax, 7
mov     rdx, 0
xsave   [storedata]

;save incoming rdi, rsi in safe place 
mov     r15, rdi ;r11 is the array
mov     r12, rsi ;r12 is size of array

;make loop counter
xor    r14, r14 ;r15 is loop counter

;start of loop
begin:

;Block outputs 1 number
mov     rax, 1
mov     rdi, hexform
mov     rsi, qword [r15 + 8 * r14]      ;64 bits = qword 
movsd    xmm0, qword [r15 + 8 * r14]

call printf
inc     r14
cmp     r14, r12     ;r14 starts at 0, when r10 equals rsi(size of array) the array is full used to be rsi
jge done ;array is full so jump to done

jmp     begin 

done:
mov     rax, 0


;restore floating-point registers
mov     rax, 7
mov     rdx, 0
xrstor  [storedata]
  

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

