 .org $0000
 lda #$FF
 sta $6002
 sta $6003
 
start: 
 lda #%11100011  ; Set 8-bit mode; 2-line display; 5x8 font
 sta $6001 
 jmp start
 .org $fffc
 .word $0000
 .word $0000
