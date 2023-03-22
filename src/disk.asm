;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             disk.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Commander X16 Disk Helpers
;*********************************************************************
.ifndef DISK_INC
DISK_INC  = 1

.segment "CODE"

;*********************************************************************
; Function:         disk_load_into_vram
; Uses:             A = filename length
;                   X = filename msb
;                   Y = filename lsb
;                   ZP_ARG1 = ADDR_LO
;                   ZP_ARG2 = ADDR_MID
;                   ZP_ARG3 = ADDR_HI
; Returns:          A = 0 on success
;                       1 on fail
; Description:      Loads a file into VRAM from disk
;*********************************************************************
disk_load_into_vram:
            jsr SETNAM

            lda #1
            ldx #8
            ldy #0
            jsr SETLFS

            lda ZP_ARG3
            ldx ZP_ARG1
            ldy ZP_ARG2
            clc
            jsr LOAD

            bcs @success
            lda #1
            rts

@success:
            lda #0
            rts

;*********************************************************************
; Function:         disk_load_into_bank
; Uses:             A = filename length
;                   X = filename msb
;                   Y = filename lsb
;                   ZP_ARG1 = Bank Number
; Returns:          A = 0 on success
;                       1 on fail
; Description:      Loads a file into VRAM from disk
;*********************************************************************            
disk_load_into_bank:
            jsr SETNAM

            lda #1
            ldx #8
            ldy #0
            jsr SETLFS

            lda ZP_ARG1
            sta RAM_BANK

            lda #0
            ldx #<RAM_WIN
            ldy #>RAM_WIN
            clc
            jsr LOAD

            bcs @success
            lda #1
            rts

@success:
            lda #0
            rts
            

.endif
