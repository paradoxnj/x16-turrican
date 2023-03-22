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


;**********************************************************************
; BSS Variables
;**********************************************************************
.segment "BSS"

oldirq:     .res 2                  ; Stores the old VERA IRQ address

.endif
