;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             x16-turrican.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Main entry point for Turrican
;*********************************************************************
.org $080D

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

        Load16 level_init_fn, level1_1_init
        Load16 level_tick_fn, level1_1_tick

        lda #>@level_init_rts
        pha
        lda #<@level_init_rts
        pha
        jmp (level_init_fn)

@level_init_rts:
        nop

        jsr player_init
        jsr video_init_irq

@mainloop:
        ; Check for VSYNC
        wai
        lda VSYNC
        beq @mainloop

        ; Check Input
        jsr input_check
        jsr player_tick

        ; Level logic
        lda #>@level_tick_rts
        pha
        lda #<@level_tick_rts
        pha
        jmp (level_tick_fn)

@level_tick_rts:
        nop

        stz VSYNC
        stz Joy1Status
        jmp @mainloop

        rts

.include "filenames.asm"
.include "disk.asm"
.include "input.asm"
.include "sprites.asm"
.include "video.asm"
.include "player.asm"
.include "level1-1.asm"

.segment "BSS"
oldirq:                         .res 2                  ; Stores the old VERA IRQ address

level_init_fn:                  .res 2                  ; Callback to level init function
level_tick_fn:                  .res 2                  ; Callback to level tick function

