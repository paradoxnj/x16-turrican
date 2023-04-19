;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             player.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Player data and functions
;*********************************************************************
.ifndef PLAYER_INC
PLAYER_INC  = 1

.segment "CODE"

player_init:
            ; Load Hero palette
            lda #(^VRAM_palette01) + 2
            sta ZP_ARG3
            lda #>VRAM_palette01
            sta ZP_ARG2
            lda #<VRAM_palette01
            sta ZP_ARG1

            lda #(hero_sprite_pal_fn_end-hero_sprite_pal_fn)
            ldx #<hero_sprite_pal_fn
            ldy #>hero_sprite_pal_fn

            jsr disk_load_into_vram

            ; Load Hero sprite
            ; Load Hero palette
            lda #(^VRAM_HEROSPRITE) + 2
            sta ZP_ARG3
            lda #>VRAM_HEROSPRITE
            sta ZP_ARG2
            lda #<VRAM_HEROSPRITE
            sta ZP_ARG1

            lda #(hero_sprite_fn_end-hero_sprite_fn)
            ldx #<hero_sprite_fn
            ldy #>hero_sprite_fn

            jsr disk_load_into_vram

            ; Initialize player variables
            stz Hero_Dir                    ; Start facing right
            lda #152                        ; Hero Screen X
            sta Hero_ScrPosX
            lda #104                        ; Hero Screen Y
            sta Hero_ScrPosY

            ; Initialize player sprite
            SPRITE_SET_ATTRIDX(SPR_IDX_HERO)

            SPRITE_SET_ADDR(VRAM_HEROSPRITE)

            Load16 ZP_ARG1,$0098            ; Set Sprite Position on screen
            Load16 ZP_ARG2,$0068
            jsr sprite_set_pos

            lda #(SPRITE_L1)                ; Set the Z-level
            sta VERA_data0

            lda #(SPRITE_HEIGHT_32 | SPRITE_WIDTH_16 | PALOFFSET_HERO)
            sta VERA_data0

            rts

player_tick:
            rts

.endif