;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             input.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Commander X16 Input helpers
;*********************************************************************
.ifndef INPUT_INC
INPUT_INC = 1

.segment "CODE"

;*********************************************************************
; Function:         input_check
; Uses:             NONE
; Returns:          VOID
; Description:      Reads the Joystick and stores in ZP variables
;*********************************************************************
input_check:
        Move16 Joy1Status, Joy1Change
        jsr JOYSTICK_SCAN
        lda #1
        jsr JOYSTICK_GET
        sta Joy1Status
        rts

.endif
