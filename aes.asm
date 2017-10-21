section .data
	blocklen equ 16
	input times blocklen db 0
	output times blocklen db 0

	Nb equ 4
	Nk equ 4
	Nr equ 10
	key times Nk dd 0
	State times 4 * Nb db 0
	
	pbyte db 0

	sbox db 0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76
	db 0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0
	db 0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15
	db 0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75
	db 0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84
	db 0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF
	db 0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8
	db 0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2
	db 0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73
	db 0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB
	db 0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79
	db 0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08
	db 0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A
	db 0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E
	db 0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF
	db 0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16

	inv_sbox db 0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38, 0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB
	db 0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87, 0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB
	db 0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D, 0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E
	db 0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2, 0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25
	db 0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16, 0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92
	db 0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA, 0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84
	db 0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A, 0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06
	db 0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02, 0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B
	db 0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA, 0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73
	db 0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85, 0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E
	db 0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89, 0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B
	db 0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20, 0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4
	db 0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31, 0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F
	db 0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D, 0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF
	db 0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0, 0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61
	db 0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26, 0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D

section .text
global _start

_start:
	xor r10,r10		; set input to 00 .. 0f for testing
loopy:
	mov [input + r10], r10
	inc r10
	cmp r10, blocklen
	jne loopy

	call inptostate

	mov [pbyte], byte 'I'
	call printchar
	mov rax, input
	call printary16
	call newline
	mov [pbyte], byte 'S'
	call printchar
	mov rax, State
	call printary16
	call newline

;	call subbytes
;	mov rax, State
;	call printary16
;	call newline

;	call invsubbytes	; test subbytes/invsubbytes
;	mov rax, State
;	call printary16
;	call newline


	mov [pbyte], byte 'A'
	call printchar
	call shiftrows
	mov rax, State
	call printary16
	call newline

	mov [pbyte], byte 'B'
	call printchar
	call invshiftrows
	mov rax, State
	call printary16
	call newline

	; XXX

	mov [pbyte], byte 'O'
	call printchar
	call statetoout
	mov rax, output
	call printary16
	call newline

	mov rax, 0
	jmp exit

;;--------------------------------------------------------------------------------

;; FIPS 197 Section 5.1.1
subbytes:
	xor rdi, rdi
subbytesloop:
	mov al, [State + rdi]
	mov cl, [sbox + rax]
	mov [State + rdi], cl
	inc rdi
	cmp rdi, blocklen
	jne subbytesloop
	ret

;; FIPS 197 Section 5.1.1
invsubbytes:
	xor rdi, rdi
invsubbytesloop:
	mov al, [State + rdi]
	mov cl, [inv_sbox + rax]
	mov [State + rdi], cl
	inc rdi
	cmp rdi, blocklen
	jne invsubbytesloop
	ret
	
;;--------------------------------------------------------------------------------

;; FIPS 197 Section 3.4
inptostate:
	xor rax, rax 		; row
inptostateloop2:
	xor rdi, rdi		; col
inptostateloop:
	mov r9b, [input + rax + Nb*rdi]
	mov [State + rdi + Nb*rax], r9b
	inc rdi
	cmp rdi, Nb
	jne inptostateloop
	inc rax
	cmp rax, Nb
	jne inptostateloop2
	ret

;; FIPS 197 Section 3.4
statetoout:
	xor rax, rax		; row
statetooutloop2:
	xor rdi, rdi		; col
statetooutloop:
	mov r9b, [State + rax + Nb*rdi]
	mov [output + rdi + Nb*rax], r9b
	inc rdi
	cmp rdi, Nb
	jne statetooutloop
	inc rax
	cmp rax, Nb
	jne statetooutloop2
	ret
	
;;--------------------------------------------------------------------------------

;; FIPS 197 Section 5.1.2
shiftrows:
	mov eax, [State + Nb]	; row 1
	rol eax, 8
	mov [State + Nb], eax
	mov eax, [State + 2*Nb]	; row 2
	rol eax, 16
	mov [State + 2*Nb], eax
	mov eax, [State + 3*Nb]	; row 3
	rol eax, 24
	mov [State + 3*Nb], eax
	ret

invshiftrows:
	mov eax, [State + Nb]	; row 1
	ror eax, 8
	mov [State + Nb], eax
	mov eax, [State + 2*Nb] ; row 2
	ror eax, 16
	mov [State + 2*Nb], eax
	mov eax, [State + 3*Nb]	; row 3
	ror eax, 24
	mov [State + 3*Nb], eax
	ret

;;--------------------------------------------------------------------------------

;; rax = return code to shell
exit:
	mov rdi, rax
	mov rax, 60
	syscall

;; print a 16-byte array
;; uses: all regs, [pbyte]
;; rax - array to print
printary16:
	mov r12, rax
	xor r10, r10

printaryloop:
	mov al, [r12 + r10]
	call printhex
	inc r10
	cmp r10, blocklen
	jne printaryloop
	ret

;; print a single byte in hex.
;; al = byte to print
printhex:
	mov r9b, al
	shr al, 4
	and al, 0x0f
	call printhexnib
	mov al, r9b
	and al, 0x0f
	call printhexnib
	ret
	
;; print a single nibble in hex
;; al - nibble to print
printhexnib:
	add al, '0'
	cmp al, '9'
	jbe digit
	add al, 7		; 'A' - '0'
digit:
	mov [pbyte], al
	call printchar
	ret

;; print a single character
;; [pbyte] - byte to print
printchar:
	mov rax, 1
	mov rdi, 1
	mov rsi, pbyte
	mov rdx, 1
	syscall
	ret

;; print a newline
newline:
	mov [pbyte], byte 0x0a
	call printchar
	ret
