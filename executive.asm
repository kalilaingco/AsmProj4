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

global executive

extern printf
extern strlen
extern printf
extern scanf
extern atoi
extern fgets
extern stdin
extern fill_random_array
extern isnan
extern normalize_array
extern Sort
extern show_array

segment .data
    msg_normalize db "The normalised number is: 0x%016lx %34.13g", 10, 0
    pi dq 3.14
    nameMessage db "Please enter your name: ", 10, 0
    titleMessage db "Please enter your title (Mr, Ms, Sargent, Chief, Project Leader,etc)",10, 0
    greeting db "Nice to meet you %s %s", 10, 0
    about db "This program will generate 64-bit IEEE float numbers.", 10, 0
    question db "How many numbers would you like? Today's limit is 100 per customer. ", 0
    initialArray db "Your numbers have been stored in an array. Here is that array", 10 ,0 
    normalizedArray db "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array", 10,0
    sortedArray db "The array will now be sorted", 10,0 
    bye db "Goodbye %s. You are welcome any time.", 10,0
    stringform db "%s", 0
    floatform db "%lf", 0
    hundred dq 100
    errorMessage db "The program cannot currently handle that many random numbers. Please try again.", 10,0
    numberDesc db "IEEE754                 Scientific Decimal", 10,0
segment .bss
align 64

name resb 100       ;buffer to hold the name of user 
title resb 100      ;buffer to hold title of user
number resb 100     ;buffer to hold how many numbers the user wants **this is a string, must be converted to int later
userArray resq 100  ;reserve 100 quadwords for random numbers 
segment .text

executive: 
;back up GPRs

push    rbp
mov     rbp, rsp
push    rbx
push    rcx
push    rdx
push    rsi
push    rdi
push    r8
push    r9
push    r10
push    r11
push    r12
push    r13
push    r14
push    r15
pushf

;print name message
mov     rax, 0
mov     rdi, stringform
mov     rsi, nameMessage
call printf

;get name from user
mov     rax, 0
mov     rdi, name
mov     rsi, 100
mov     rdx, [stdin]
call fgets

;get rid of newline
mov     rax,0
mov     rdi, name
call strlen
mov     [name + rax-1], byte 0

;print title message
mov     rax, 0
mov     rdi, stringform
mov     rsi, titleMessage
call    printf

;get title from user
mov     rax, 0
mov     rdi, title
mov     rsi, 100
mov     rdx, [stdin]
call fgets

;get rid of newline 
mov     rax, 0
mov     rdi, title
call strlen
mov     [title + rax-1], byte 0

;print greeting message
mov     rax, 0
mov     rdi, greeting
mov     rsi, title
mov     rdx, name
call printf

;print about message
mov     rax, 0
mov     rdi, stringform
mov     rsi, about
call printf

tryAgain:
;print question message
mov     rax, 0
mov     rdi, stringform
mov     rsi, question
call printf

;get amount of numbers the user would like 
mov     rax, 0
mov     rdi, number
mov     rsi, 100
mov     rdx, [stdin]
call fgets 

;remove newline
mov     rax, 0
mov     rdi, number
call    strlen
mov     [number + rax-1], byte 0

;convert from string to int
mov     rax, 0
mov     rdi, number
call    atoi
mov     r14, rax

;check to make sure number is <=100 , if greater than jump to error loop
mov     rax, 0
cmp     r14, [hundred]
jg  errorLoop
jmp continue

errorLoop:
mov     rax, 0
mov     rdi, stringform
mov     rsi, errorMessage
call    printf
jmp     tryAgain


continue: 
; "your numbers have have been stored in an array ...."
mov     rax, 0
mov     rdi, stringform
mov     rsi, initialArray
call    printf


;call fill_random_array
mov     rax, 0
mov     rdi, userArray
mov     rsi, r14
call    fill_random_array 

;output number description message 
mov     rax,0
mov     rdi, stringform
mov     rsi, numberDesc
call    printf

;output new filled array 
mov         rax, 0
mov         rdi, userArray
mov         rsi, r14
call        show_array

;print "normalized" message
mov     rax, 0
mov     rdi, stringform
mov     rsi, normalizedArray
call    printf

;call normalize_array
mov     rax, 0
mov     rsi, userArray
mov     rdi, r14
call    normalize_array

;output number description message 
mov     rax,0
mov     rdi, stringform
mov     rsi, numberDesc
call    printf

;output normalized array 
mov         rax, 0
mov         rdi, userArray
mov         rsi, r14
call        show_array


;call Sort array
mov         rax, 0
mov         rdi, userArray ;used to be userArray
mov         rsi, r14
call        Sort

; "This is the sorted array message"
mov         rax, 0
mov         rdi, stringform
mov         rsi, sortedArray
call        printf 

;output number description message 
mov     rax,0
mov     rdi, stringform
mov     rsi, numberDesc
call    printf

;output new sorted array 
mov         rax, 0
mov         rdi, userArray
mov         rsi, r14
call        show_array

;print goodbye message
mov         rax, 0
mov         rdi, bye
mov         rsi, title
call        printf


;return name to main.c
mov     rax, name 


;restore the original values to the GPR
popf
pop     rbx
pop     r15
pop     r14
pop     r13
pop     r12
pop     r11
pop     r10
pop     r9
pop     r8
pop     rcx
pop     rdx
pop     rsi
pop     rdi
pop     rbp
ret