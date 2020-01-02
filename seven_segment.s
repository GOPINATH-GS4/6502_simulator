PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000
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
 cpx #$12
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
 .word $0011 

clear_display:
 pha 
 lda #%00001110 ; Display on; cursor on; blink off
 jsr set_register
 pla
 rts

set_register:
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set E bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts
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
