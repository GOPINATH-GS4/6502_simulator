 .org $4000
start: 
 lda #$ff
 sta $6002
 ldx #$00
 stx $6000
loop: 
 stx $6000
 inx
 cpx #$ff
 bne loop
 ldx #$00
 jmp loop 
 
 .org $fffc 
 .word start
 .word $0000
