.syntax unified
.cpu cortex-m4
.text

.global Ten32
.thumb_func
.align
Ten32:
    MOV R0, 10
    BX LR

.global Ten64
.thumb_func
.align
Ten64:
    MOV R0, 10
    MOV R1, 0
    BX LR

.global Incr
.thumb_func
.align
Incr:
    MOV R1, 1
    ADD R0, R0, R1
    BX LR

.global Nested1
.thumb_func
.align
Nested1:
    PUSH {LR}
    BL rand
    ADD R0, R0, 1
    POP {PC}

.global Nested2
.thumb_func
.align
Nested2:
    PUSH {LR}
    BL rand
    PUSH {R0}
    BL rand
    POP {R1}
    ADD R0, R0, R1
    POP {PC}

.global PrintTwo
.thumb_func
.align
PrintTwo:
    PUSH {LR}
    PUSH {R0, R1}
    BL printf
    POP {R0, R1}
    ADD R1, 1
    BL printf
    POP {PC}

.end
