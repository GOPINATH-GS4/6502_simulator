PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

reset:
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB

  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr set_register

  lda #%00001110 ; Display on; cursor on; blink off
  jsr set_register

  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr set_register

  lda #%00000001 ; Clear display
  jsr set_register

  lda #"H"
  jsr output_char
  lda #"a"
  jsr output_char
  lda #"p"
  jsr output_char
  lda #"p"
  jsr output_char
  lda #"y"
  jsr output_char
  lda #" "
  jsr output_char
  lda #"N"
  jsr output_char
  lda #"e"
  jsr output_char
  lda #"w"
  jsr output_char
  lda #" "
  jsr output_char
  lda #"Y"
  jsr output_char
  lda #"e"
  jsr output_char
  lda #"a"
  jsr output_char
  lda #"r"
  jsr output_char
  lda #"!"
  jsr output_char

  lda #%0011000000
  jsr set_register 

  lda #"1"
  jsr output_char 
  lda #" "
  jsr output_char 
  lda #"J"
  jsr output_char 
  lda #"A"
  jsr output_char 
  lda #"N"
  jsr output_char 
  lda #" "
  jsr output_char 
  lda #"2"
  jsr output_char 
  lda #"0"
  jsr output_char 
  lda #"2"
  jsr output_char 
  lda #"0"
  jsr output_char 
  lda #" "
  jsr output_char 
  
loop:
  jmp loop

output_char:

  sta PORTB
  lda #RS         ; Set RS; Clear RW/E bits
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction
  sta PORTA
  lda #RS         ; Clear E bits
  sta PORTA
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
 

  .org $fffc
  .word reset
  .word $0000
