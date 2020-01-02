 .org $0000
 lda #$FF
 sta $6002
 
start: 
 lda #$F2
 sta $6000 
 jmp start
 .org $fffc
 .word $0000
 .word $0000
