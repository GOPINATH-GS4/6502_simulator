 .org $4000
start: 
 lda #$ff
 sta $6002
 sta $6003
loop0:
 ldx #$00
 ldy #$00
loop1: 
 lda digits,X
 sta $6001
loop2: 
 lda digits,Y 
 sta $6000
 iny 
 cpy #$10
 bne loop2
 ldy #$00
 inx
 cpx #$10
 bne loop1
 ldx #$00
 jmp loop0 

digits:
 .word $60FC
 .word $F2DA
 .word $B666
 .word $E0BE
 .word $F6FE
 .word $3EEE
 .word $7A9C
 .word $8E9E
 .word $0001 

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
