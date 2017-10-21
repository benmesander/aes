section .data
	blocklen equ 16
	input times blocklen db 0
	output times blocklen db 0

	Nb equ 4
	Nk equ 4
	Nr equ 10
	key times Nk dd 0
	State times 4 * Nb db 0
	

section .text
global _start

_start:
	call inptostate

	; XXX

	call statetoout

	jmp exit

exit:
	mov rax, 60
	mov rdi, 0
	syscall

inptostate:
	xor rax, rax
inptostateloop:
	mov bl, [input + rax]
	mov [State + rax], bl
	inc rax
	cmp rax, blocklen
	jne inptostateloop
	ret

statetoout:
	xor rax, rax
statetooutloop:
	mov bl, [State + rax]
	mov [State + rax], bl
	inc rax
	cmp rax, blocklen
	jne statetooutloop
	ret
	
