.syntax unified
.cpu cortex-m4
.text

.global CallReturnOverhead
.thumb_func
.align
CallReturnOverhead: BX LR

.global ReverseBits
.thumb_func
.align
ReverseBits:
    .rept 32
    LSLS R0, R0, 1 //Shift MSB of R0 to C
    RRX R1, R1 //Rotate R1 right, carrying C in
    .endr
    MOV R0, R1
    BX LR

.global ReverseBytes
.thumb_func
.align
ReverseBytes: //R0 holds bytes abcd
    BFI R1, R0, 24, 8 //R1 holds d---
    LSR R0, R0, 8 //R0 holds -abc
    BFI R1, R0, 16, 8 //R1 holds dc--
    LSR R0, R0, 8 //R0 holds --ab
    BFI R1, R0, 8, 8 //R1 holds dcb-
    LSR R0, R0, 8 //R0 holds ---a
    BFI R1, R0, 0, 8 //R1 holds dcba
    MOV R0, R1
    BX LR








//
