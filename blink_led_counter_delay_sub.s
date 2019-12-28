 .org $0000
start: 
 lda #$ff
 sta $6002
 ldx #$00
 stx $6000
loop: 
 jsr delay
 stx $6000
 inx
 cpx #$ff
 bne loop
 ldx #$00
 jmp loop 

delay:
 nop
 nop
 nop
 nop
 nop
 rts 
 .org $fffc 
 .word start
 .word $0000
