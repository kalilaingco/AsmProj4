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


global fill_random_array

extern printf       ;for error checking
extern rdrand
extern isnan


segment .data

msg_random db "The random number is: 0x%0161x %34.13g", 10,0       ;formatting from assignment description
msg_error db "error", 10,0
pi dq 3.14

segment .bss
align 64
storedata resb 1024

segment .text

fill_random_array:
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
mov     r13, rdi        ;userArray buffer
mov     r12, rsi        ;size
xor     r11, r11        ; counter

;generate random number
regenerate:
    rdrand      r15    
    push        r15     ;rsp will point to r15

;call isnan to verify if usable number 
    movsd       xmm15, [rsp]
    pop         rax
    movsd       xmm0, xmm15
    call        isnan 
    cmp         rax, 1
    jge         error
    jmp         addToArray


error: 
    mov     rax, 0
    mov     rdi, msg_error      ;print error if NaN gets generated
    call    printf
    jmp regenerate 

;add verified usable number to array and then increment 
addToArray:
    mov     rax, 0
    mov     qword[r13 + 8* r11], r15
    inc     r11
    cmp     r11, r12
    jge     finish
    jmp     regenerate

finish:

;restore floating-point numbers
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

