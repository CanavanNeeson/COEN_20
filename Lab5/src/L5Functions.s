.syntax unified
.cpu cortex-m4
.text

.global DeleteItem
.thumb_func
.align
DeleteItem:
    LSL R1, R1, 2
    LSL R2, R2, 2 //Multiply indices by 4
    SUB R1, R1, 4
    DeleteItemTop: CMP R2, R1
        BGE DeleteItemEnd
        ADD R2, R2, 4
        LDR R3, [R0, R2]//R3 = data[items + #iterations + 1]
        SUB R2, R2, 4
        STR R3, [R0, R2] //data[items + #iterations] = R3
        ADD R2, R2, 4  //Increment pointer to current item
        B DeleteItemTop

    DeleteItemEnd:
    BX LR




.global InsertItem
.thumb_func
.align
InsertItem:

    LSL R1, R1, 2
    LSL R2, R2, 2 //Multiply indices by 4
    ADD R1, R1, R0
    ADD R2, R2, R0
    SUB R1, R1, 4 //Indices now contain addresses.
    //The value of R0 is not needed

    InsertItemTop: CMP R1, R2
        BLE InsertItemEnd
        LDR R0, [R1, -4]
        STR R0, [R1]
        SUB R1, R1, 4
        B InsertItemTop

    InsertItemEnd:
    STR R3, [R2]
    BX LR








    // LSL R1, R1, 2
    // LSL R2, R2, 2 //Multiply indices by 4
    // //SUB R1, R1, 4 //Subtract 4 from items
    // InsertItemTop:  CMP R1, R2
    //     BLT InsertItemEnd //Break if R1 > R2
    //     SUB R1, R1, 8
    //     LDR R12, [R0, R1]
    //     ADD R1, R1, 4
    //     STR R12, [R0, R1]
    //
    //     B InsertItemTop
    // InsertItemEnd:
    // STR R3, [R0, R2]
    // BX LR



//
