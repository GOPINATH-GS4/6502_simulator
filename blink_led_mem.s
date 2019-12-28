 .org $0000

start:
 lda #$ff
 sta $6002

loop:
 lda #$81 
 sta $6000 
 lda #$72 
 sta $6000 
 lda #$27 
 sta $6000 
 lda #$18 
 sta $6000 

 jmp loop
  
 .org $7000
 .word $81
 .word $72
 .word $27
 .word $18 
 .org $fffc 
 .word start
 .word $0000
