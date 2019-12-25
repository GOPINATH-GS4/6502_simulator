 .org $4000
start: 
 lda #$ff
 sta $6002
 sta $6003
 lda #$00
 sta $6001
 lda #$00
 sta $6003
 lda #$ff
 sta $6000
loop: 
 lda #$ff
 and $6001
 sta $6000
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
