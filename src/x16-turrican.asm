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
        ;jsr print_string
        jsr video_init
        ;jsr print_string
        
        stz Joy1Change
        stz Joy1Status
        stz VSYNC

        lda #(^VRAM_palette) + 2
        sta ZP_ARG3
        lda #>VRAM_palette
        sta ZP_ARG2
        lda #<VRAM_palette
        sta ZP_ARG1

        lda #(level_1_1_pal_fn_end-level_1_1_pal_fn)
        ldx #<level_1_1_pal_fn
        ldy #>level_1_1_pal_fn
 
        jsr disk_load_into_vram

        lda #(^VRAM_TILES) + 2
        sta ZP_ARG3
        lda #>VRAM_TILES
        sta ZP_ARG2
        lda #<VRAM_TILES
        sta ZP_ARG1

        lda #(level_1_1_tiles_fn_end-level_1_1_tiles_fn)
        ldx #<level_1_1_tiles_fn
        ldy #>level_1_1_tiles_fn
 
        jsr disk_load_into_vram

        lda #2
        sta ZP_ARG3
        stz ZP_ARG2
        stz ZP_ARG1

        lda #(level_1_1_l0map_fn_end-level_1_1_l0map_fn)
        ldx #<level_1_1_l0map_fn
        ldy #>level_1_1_l0map_fn

        jsr disk_load_into_vram

        jsr video_init_irq

        lda #$C0
        sta VERA_L0_hscroll_l
        lda #$02
        sta VERA_L0_hscroll_h

        lda #$B0
        sta VERA_L0_vscroll_l
        lda #$03
        sta VERA_L0_vscroll_h

@mainloop:
        wai
        lda VSYNC
        beq @mainloop
        jsr input_check
        stz VSYNC
        stz Joy1Status
        jmp @mainloop

        rts

print_string:
        ldx #0
@l:
        lda level_1_1_l0map_fn,X
        beq @done
        jsr CHROUT
        inx
        jmp @l
@done:
        rts

.include "filenames.asm"
.include "disk.asm"
.include "input.asm"
.include "sprites.asm"
.include "video.asm"
