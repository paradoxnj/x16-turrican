;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             filenames.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      File names for assets
;*********************************************************************
.ifndef FILENAMES_INC
FILENAMES_INC  = 1

.segment "CODE"

level_1_1_tiles_fn: .literal "1-1.TIL"
level_1_1_tiles_fn_end:

level_1_1_pal_fn:   .literal "1-1.PAL"
level_1_1_pal_fn_end:

level_1_1_l0map_fn: .literal "1-1.TER"
level_1_1_l0map_fn_end:

hero_sprite_fn: .literal "HERO.SPR"
hero_sprite_fn_end:

hero_sprite_pal_fn: .literal "HERO.PAL"
hero_sprite_pal_fn_end:

.endif
