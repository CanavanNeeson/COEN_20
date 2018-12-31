.syntax unified
.cpu cortex-m4
.text

.global Discriminant
.thumb_func
.align
Discriminant:
    VMUL.F32 S2, S0, S2 //S2 = a*c
    VMUL.F32 S0, S1, S1 //S0 = b^2
    VMOV S3, 4.0 //S3 = 4
    VMLS.F32 S0, S2, S3 //S0 = b^2 - 4ac
    BX LR

.global Root1
.thumb_func
.align
Root1:
    PUSH {R4, R5, LR}
    VMOV R4, S0 //R4 = a
    VMOV R5, S1 //R5 = b
    BL Discriminant //S0 = Discriminant
    VSQRT.F32 S0, S0 //S0 = sqrt(Discriminant)
    VMOV S1, R4 //S1 = a
    VMOV S2, R5 //S2 = b
    VSUB.F32 S0, S2 //S0 = sqrt(Discriminant) - b
    VMOV S3, 2.0 //S3 = 2
    VMUL.F32 S1, S1, S3 //S1 = 2a
    VDIV.F32 S0, S0, S1
    POP {R4, R5, PC}


.global Root2
.thumb_func
.align
Root2:
    PUSH {R4, R5, LR}
    VMOV R4, S0
    VMOV R5, S1 //S0 and S1 stored
    BL Discriminant //S0 = Discriminant
    VSQRT.F32 S0, S0 //S0 = sqrt(Discriminant)
    VMOV S1, R4 //S1 = a
    VMOV S2, R5 //S2 = b
    VNEG.F32 S0, S0 //S0 = -sqrt(Discriminant)
    VSUB.F32 S0, S2 //S0 = sqrt(Discriminant) - b
    VMOV S3, 2.0 //S3 = 2
    VMUL.F32 S1, S1, S3 //S1 = 2a
    VDIV.F32 S0, S0, S1
    POP {R4, R5, PC}

.global Quadratic
.thumb_func
.align
Quadratic:
    VMUL.F32 S1, S1, S0 //S1 = ax
    VADD.F32 S1, S1, S2 //S1 = ax + b
    VMUL.F32 S0, S1, S0 //S0 = ax^2 + bx
    VADD.F32 S0, S0, S3 //S0 = ax^2 + bx + c
    BX LR










//
