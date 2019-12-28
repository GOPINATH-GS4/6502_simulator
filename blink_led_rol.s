 .org $8000

start:
 lda #$ff
 sta $6002
 lda #$01
loop:
 rol
 sta $6000 

 jmp loop

 .org $fffc 
 .word start
 .word $0000
