section .data
blocklen equ 16
	input times blocklen db 0
	output times blocklen db 0

	pbyte db 0

section .text
global _start

_start:
	xor r10,r10
loopy:
	mov [input + r10], r10
	inc r10
	cmp r10, blocklen
	jne loopy

	mov rax, input
	call printary16
	call newline

	mov rax, output
	call printary16
	call newline

	mov rax, 60
	mov rdi, 0
	syscall			; exit(0)

;; print a 16-byte array
;; uses: all regs, [pbyte]
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
