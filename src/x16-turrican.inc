;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             x16-turrican.inc
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Constants and Macros for Turrican
;*********************************************************************
.ifndef TURRICAN_INC
TURRICAN_INC  = 1

;*******************************************************************
; Memory Map
;*******************************************************************
VRAM_TILES          = $16000
VRAM_MAP            = $00000
VRAM_HEROSPRITE     = $08008

VRAM_palette01      = $1FA20        ; Hero Palette

BANK_COLLISION      = 2
BANK_OVERRIDE       = 3
BANK_ENTITY         = 4

SPR_IDX_HERO        = 1

; Palettes 
PALOFFSET_WORLD     = 0
PALOFFSET_HERO      = 1

;*******************************************************************
; Zero Page Variables
;*******************************************************************
VSYNC               = $40           ; VSYNC Flag

Joy1Change          = $42           ; Previous joystick status
Joy1Status          = $44           ; Current joystick status

Hero_Dir            = $70           ; Direction hero is facing 0 = Right, 1 = Left (8-bits)
Hero_WrlPosX        = $72           ; X Position in world (16-bits)
Hero_WrlPosY        = $74           ; Y Position in world (16-bits)
Hero_ScrPosX        = $76           ; X Position on screen (8-bits)
Hero_ScrPosY        = $77           ; Y Position on screen (8-bits)

Camera_X            = $80           ; X Position of the camera (scroll register) (16-bits)
Camera_Y            = $82           ; Y Position of the camera (scroll register) (16-bits)

;*******************************************************************
; Macros
;*******************************************************************
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
