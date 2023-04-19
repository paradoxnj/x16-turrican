;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             level1-1.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Level 1-1 logic and initialization
;*********************************************************************
.ifndef LEVEL1_1_INC
LEVEL1_1_INC  = 1

.segment "CODE"

level1_1_init:
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

        lda #$C0
        sta VERA_L0_hscroll_l
        lda #$02
        sta VERA_L0_hscroll_h

        lda #$30
        sta VERA_L0_vscroll_l
        lda #$01
        sta VERA_L0_vscroll_h

        rts

level1_1_tick:
        rts

.endif
