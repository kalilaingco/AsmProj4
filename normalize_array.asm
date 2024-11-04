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


global normalize_array
extern printf
extern rdrand

segment .data

msg_normalized db "The normalised number is: 0x%016lx %34.13g", 10, 0

segment .bss

align 64
storedata resb 1024

segment .text

normalize_array:

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

;save float registers 
mov     rax, 7
mov     rdx, 0
xsave   [storedata]

;save parameters passed to stable registers 
mov     r14, rdi    ;rdi is array size
mov     r13, rsi     ;rsi is array 
xor     r12, r12    ;counter for size of array

begin:
; Normalize the random number
mov     r10, 0x000FFFFFFFFFFFFF         ;save mantissa
mov     r15, [r13 + 8 * r12]      ;put copy of number into r15 

and     r15, r10
mov     r11, 0x3FF0000000000000     ;put 3FF as stored exponent 
or      r15, r11


;put number back into array
mov     [r13 + 8 * r12], r15     ;put normalize number back into array

inc     r12
cmp     r12, r14

jge done
jmp begin

;this block was for error checking 
;push    r15
;movsd   xmm15, [rsp]
;pop     rbx

;mov     rax, 1
;mov     rdi, msg_normalized
;mov     rsi, r15
;movsd   xmm0, xmm15
;call    printf

done:
mov     rax, 7
mov     rdx, 0
xrstor [storedata]

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

