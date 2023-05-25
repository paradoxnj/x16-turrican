;*********************************************************************
; Project:          Turrican Port for Commander X16
; File:             video.asm
; Author:           Anthony Rufrano (paradoxnj)
; Description:      Commander X16 Video Helpers
;*********************************************************************
.ifndef VIDEO_INC
VIDEO_INC  = 1

.segment "CODE"

;*********************************************************************
; Function:         video_init
; Uses:             NONE
; Returns:          VOID
; Description:      Initalizes VERA and prepares for rendering
;*********************************************************************
video_init:
            stz VERA_ctrl

            lda #(VIDEO_SPRITES_ENABLED | VIDEO_LAYER0_ENABLED | VIDEO_OUTPUT_VGA)
            sta VERA_dc_video

            lda #64
            sta VERA_dc_hscale
            sta VERA_dc_vscale

            lda #(MAP_HEIGHT_128 | MAP_WIDTH_128 | COLOR_4BPP)
            sta VERA_L0_config

            lda #(VRAM_MAP >> 9)
            sta VERA_L0_mapbase

            lda #((VRAM_TILES >> 9) | TILE_HEIGHT_16 | TILE_WIDTH_16)
            sta VERA_L0_tilebase

            stz VERA_L0_vscroll_l
            stz VERA_L0_vscroll_h
            stz VERA_L0_hscroll_l
            stz VERA_L0_hscroll_h

            rts

;*********************************************************************
; Function:         video_init_irq
; Uses:             NONE
; Returns:          VOID
; Description:      Initalizes custom VERA IRQ routine
;*********************************************************************
video_init_irq:
            stz VSYNC
            sei
            lda IRQVec
            sta oldirq
            lda IRQVec+1
            sta oldirq+1
            lda #<video_handle_irq
            sta IRQVec
            lda #>video_handle_irq
            sta IRQVec+1
            cli

            rts

;*********************************************************************
; Function:         video_handle_irq
; Uses:             NONE
; Returns:          VOID
; Description:      Custom VERA IRQ handler
;*********************************************************************
video_handle_irq:
            lda VERA_isr
            and #$01
            beq @done
            sta VSYNC
@done:
            jmp (oldirq)

;*********************************************************************
; Function:         video_calc_start_pos
; Uses:             X = X Position
;                   Y = Y Position
; Returns:          Camera_X = X Scroll Position
;                   Camera_Y = Y Scroll Position
; Description:      Calculates the start position based on Tile XY
;*********************************************************************
video_calc_start_pos:
            stx ZP_ARG1
            stz ZP_ARG1+1
            Move16 ZP_ARG1, Camera_X
            Asl16 Camera_X              ; Camera_X * 16
            Asl16 Camera_X
            Asl16 Camera_X
            Asl16 Camera_X
            Sub16 Camera_X, $0098       ; (Screen_Width / 2) - (Sprite_Width / 2)
                                        ; (320 / 2) - (16 / 2) = 152 ($98)

            sty ZP_ARG1
            stz ZP_ARG1+1
            Move16 ZP_ARG1, Camera_Y
            Asl16 Camera_Y              ; Camera_Y * 16
            Asl16 Camera_Y
            Asl16 Camera_Y
            Asl16 Camera_Y
            Sub16 Camera_Y, $0068       ; (Screen_Height / 2) - (Sprite_Height / 2)
                                        ; (240 / 2) - (32 / 2) = 104 ($68)

            ; Set VERA scroll registers for L0
            lda Camera_X
            sta VERA_L0_hscroll_l
            lda Camera_X+1
            sta VERA_L0_hscroll_h

            lda Camera_Y
            sta VERA_L0_vscroll_l
            lda Camera_Y+1
            sta VERA_L0_vscroll_h

            rts

.endif
