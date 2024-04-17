;**************************************************************
;* author: David Foster                                       
;* date:   3-19-2024                                          
;* purpose: Determine the length in bytes of null-terminated  
;* strings as sample code for lab02                           
;* inputs: two-byte address of null-term array in 3000h       
;* outputs: one-byte length in address $3002                  
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack




; variable/data section
MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
           ; TO FACILITATE DEBUGGING 
           	ORG  $3020		; create a small array of data using "define constant"
            dc.b  $64,$45,$ff,$00

           	ORG  $3040		; create a small array of data using "define constant"
            dc.b  $64,$45,$64,$56,$60,$2f,$00

           	ORG  $3060		; create a small array of data using "define constant"
      	    dc.b  $64,$45,$64,$45,$64,$45,$64,$45,$64,$45,$27,$00

            ORG  $3100    ; create a large array of data using "define constant block"
            dcb.b 500, $ff
            dc.b $00

; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDAB #0       ; This will count the length
            LDX $3000     ; point X at the first character
loop:       LDAA 0,X		  ; Grab a byte from the array
            BEQ foundEnd	; If it's 0x00, we found the end
            INCB		      ;…otherwise increment the length
            INX			      ; point to the next character
            BRA loop      ; and check again 
foundEnd:   STAB $3002	  ; output the final length 
endmain:    BRA endmain
           