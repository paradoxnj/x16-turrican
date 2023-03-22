;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             sprites.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Commander X16 Sprite Helpers
;*********************************************************************
.ifndef SPRITE_INC
SPRITE_INC  = 1

.segment "CODE"

.macro SPRITE_SET_ADDR addr
    ; Addr low
    lda #((addr >> 5) & $FF)
    sta VERA_data0

    lda #((addr >> 13) & $F)
    sta VERA_data0
.endmacro

.macro SPRITE_SET_ATTRIDX idx
    VERA_SET_ADDR($1FC00 + (idx * 8))
.endmacro

;*********************************************************************
; Function:         sprite_set_pos
; Uses:             ZP_ARG1 = Sprite X Address
;                   ZP_ARG2 = Sprite Y Address
; Returns:          VOID
; Description:      Sets the sprite's position on screen
;*********************************************************************
sprite_set_pos:
            ; X Addr low & $FF
            lda ZP_ARG1
            sta VERA_data0

            ; X Addr Hi >> 8
            lda ZP_ARG1+1
            lsr                     ; X (9:8)
            lsr
            lsr
            lsr
            lsr
            lsr
            lsr
            lsr
            sta VERA_data0

            ;Y Addr Low & $FF
            lda ZP_ARG2
            sta VERA_data0

            lda ZP_ARG2+1
            lsr                     ; Y (9:8)
            lsr
            lsr
            lsr
            lsr
            lsr
            lsr
            lsr
            sta VERA_data0

            rts

.endif
