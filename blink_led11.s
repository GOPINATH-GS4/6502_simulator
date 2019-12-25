 .org $4000
start: 
 lda #$ff
 sta $6002
 sta $6003
 ldx #$00
loop: 
 lda digits,X
 sta $6001
 sta $6000
 inx 
 jsr delay
 cpx #$11
 bne loop
 ldx #$00
 jmp loop 

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
