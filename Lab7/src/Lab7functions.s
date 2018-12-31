.syntax unified
.cpu cortex-m4
.text

.global CallReturnOverhead
.thumb_func
.align
CallReturnOverhead: BX LR

.global SDIVby13
.thumb_func
.align
SDIVby13:
    MOVS.N R1, 13
    SDIV R0, R0, R1
    BX LR

.global UDIVby13
.thumb_func
.align
UDIVby13:
    MOVS.N R1, 13
    UDIV R0, R0, R1
    BX LR

.global MySDIVby13
.thumb_func
.align
MySDIVby13:
    LDR     R1,=0x4EC4EC4F      // 2 clock cycle(s)
    SMMUL   R1,R1,R0            // 2 clock cycle(s)
    ASRS.N  R1,R1,2             // 1 clock cycle(s)
    ADD     R0,R1,R0,LSR 31     // 1 clock cycle(s)
    BX LR

.global MyUDIVby13
.thumb_func
.align
MyUDIVby13:
    LDR     R1,=0x4EC4EC4F      // 2 clock cycle(s)
    UMULL   R2,R1,R1,R0         // 1 clock cycle(s)
    LSRS.N  R0,R1,2             // 1 clock cycle(s)
    BX LR













//
