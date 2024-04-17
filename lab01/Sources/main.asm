;*************************************************************
;* author: David Foster                                       
;* date:   3-18-2024                                          
;* purpose: sum five numbers and store result, to be used in  
;* lab01 for debugging purposes                               
;* inputs: array of five one-byte numbers from $3000 to $3004 
;* outputs: one-byte sum in address $3008                     
;*************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack


; Add known I/O addresses here
            ORG  $3000


; variable/data section
MY_EXTENDED_RAM: SECTION
; Insert internal variables here



; code section - don't mess with anything from here...
MyCode:     SECTION
main:
_Startup:
Entry:
; uncomment next line if the stack is needed
;            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
;... to here.            
            LDAA 3000h                 ; add an array of one-byte numbers...
            ADDA 3001h
            ADDA 3002h
            ADDA 3003h
            ADDA 3004h
            STAA 3008h                 ; ... and store the one-byte sum
endmain     BRA endmain                ; end of program

