.syntax unified
.cpu cortex-m4
.text

.global Discriminant
.thumb_func
.align
Discriminant:
    MUL R0, R0, R2 //R0 = ac
    LSL R0, R0, 2 //R0 = 4ac
    MUL R1, R1, R1 //R1 = b^2
    SUB R0, R1, R0 //R0 = R1 - R0
    BX LR

.global Root1
.thumb_func
.align
Root1:
    PUSH {R4, R5, LR}
    MOV R4, R0 //R4 = a
    MOV R5, R1 //R5 = b
    BL Discriminant //R0 = Discriminant
    BL SquareRoot //R0 = sqrt(Discriminant)
    SUB R0, R0, R5 //R0 = -b + sqrt(Discriminant)
    ADD R4, R4, R4 //R4 = 2a
    SDIV R0, R0, R4

    POP {R4, R5, PC}

.global Root2
.thumb_func
.align
Root2:
    PUSH {R4, R5, LR}
    MOV R4, R0 //R4 = a
    MOV R5, R1 //R5 = b
    BL Discriminant
    BL SquareRoot //R0 = sqrt(Discriminant)
    NEG R0, R0 //R0 = -sqrt(Discriminant)
    SUB R0, R0, R5 //R0 = -b - sqrt(Discriminant)
    ADD R4, R4, R4 //R4 = 2a
    SDIV R0, R0, R4

    POP {R4, R5, PC}

.global Quadratic
.thumb_func
.align
Quadratic:
    MUL R1, R1, R0 //R1 = ax
    ADD R1, R1, R2 //R1 = ax + b
    MUL R0, R1, R0 //R0 = ax^2 + bx
    ADD R0, R0, R3 //R0 = ax^2 + bx + c
    BX LR

.global SquareRoot
.thumb_func
.align
SquareRoot:
    CMP R0, 2
    IT LT //if R0 < 2
        BXLT LR

    PUSH {R4, LR}
    MOV R4, R0 //R4 = n
    ASR R0, R0, 2 //R0 = n/4
    BL SquareRoot //R0 = SquareRoot(n/4)
    LSL R0, R0, 1 //R0 = 2 * SquareRoot(n / 4) = s cand
    ADD R1, R0, 1 //R0 is s cand, R1 is l cand
    MUL R2, R1, R1 //R2 = l cand * l cand
    CMP R2, R4
    IT LE
        MOVLE R0, R1 //R0 = l cand
                    //Else, R0 = s cand
    POP {R4, PC}









//
