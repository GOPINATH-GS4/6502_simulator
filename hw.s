 .org $4000
start: 
 lda #$ff
 sta $6002
 sta $6003
 ldx #$00
 lda #$60
loop:
 sta $6001
 sta $6000
 jsr delay 
 ldx #$00
 stx $6001
 stx $6000
 rol 
 cmp #$80
 bne loop 
 lda #$01
 jmp loop

digits:
 .word $6000
 .word $5B4F
 .word $666D
 .word $7D07
 .word $7F6F
 .word $777C
 .word $395E
 .word $7971
 .word $8000 

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
