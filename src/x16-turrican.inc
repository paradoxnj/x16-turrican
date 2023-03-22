;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             x16-turrican.inc
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Constants and Macros for Turrican
;*********************************************************************
.ifndef TURRICAN_INC
TURRICAN_INC  = 1

; Memory Map
VRAM_TILES          = $16000
VRAM_MAP            = $00000

BANK_COLLISION      = 2
BANK_OVERRIDE       = 3
BANK_ENTITY         = 4

Joy1Change          = $42           ; Previous joystick status
Joy1Status          = $44           ; Current joystick status

VSYNC               = $40

.macro Load16 dest, val
    lda #<(val)
    sta dest
    lda #>(val)
    sta dest+1
.endmacro

.macro Move16 src, dest
    lda src
    sta dest
    lda src+1
    sta dest+1
.endmacro

.macro Add16 dest, val
    lda dest
    clc
    adc #<(val)
    sta dest
    lda dest+1
    adc #>(val)
    sta dest+1
.endmacro

.macro Sub16 dest, val
    lda dest
    sec
    sbc #<(val)
    sta dest
    lda dest+1
    sbc #>(val)
    sta dest+1
.endmacro

.macro Lsr16 dest
    lsr dest+1
    ror dest
.endmacro

.macro Asl16 dest
    asl dest
    rol dest+1
.endmacro

.macro Inc16 dest
    inc dest
    bne :+
    inc dest+1
:
.endmacro

.macro Dec16 dest
    lda dest
    bne :+
    dec dest+1
:
    dec dest
.endmacro

.endif
