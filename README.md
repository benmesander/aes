# aes
basic implementation of AES in x86_64

This is a toy implementation with security vulnerabilities; it is unsuitable for any use other than pedagogy. I'm using it to learn a bit about crypto and X86_64 assembly.

# References:

FIPS 197 (AES specification): [https://csrc.nist.gov/csrc/media/publications/fips/197/final/documents/fips-197.pdf]
Notes on implementing AES in go: [http://blog.nindalf.com/implementing-aes/]
X86_64 tutorial: [http://0xax.blogspot.com/2014/08/say-hello-to-x64-assembly-part-1.html]
NASM assembler reference: [http://www.nasm.us/xdoc/2.13.01/html/nasmdoc0.html]
GNU emacs NASM mode: [https://github.com/skeeto/nasm-mode]

In `~/.emacs`:
`(load "~/src/nasm-mode/nasm-mode.el")
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))`

