;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             x16-turrican.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Main entry point for Turrican
;*********************************************************************
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

            jmp turrican_main

.include "x16.inc"
.include "x16-turrican.inc"

turrican_main:
        jsr video_init

        stz Joy1Change
        stz Joy1Status
        stz VSYNC

        jsr video_init_irq

@mainloop:
        wai
        lda VSYNC
        beq @mainloop
        jsr input_check
        stz VSYNC
        stz Joy1Status
        jmp @mainloop

        rts

.include "disk.asm"
.include "input.asm"
.include "sprites.asm"
.include "video.asm"
