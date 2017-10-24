# aes
basic implementation of AES in x86_64

This is a toy implementation with security vulnerabilities; it is
unsuitable for any use other than pedagogy. I'm using it to learn a
bit about crypto and X86_64 assembly. It is not particularly efficient
as it is my first x86_64 program and I did not attempt to optimize the
algorithm for the little-endian processor or use the long word length
to my advantage. It also does not use SIMD or the AES-NI instructions
available in the x86_64 as the point of the implmentation was to learn
the details of the algorithm.

AES-128 is a cipher that operates on 16-byte blocks. This
implementation takes as input a block of 16 bytes and a 16-byte key
and produces 16 bytes of encrypted output. It then runs the inverse
cipher and verifies that the decrypted result is identical to the
original data.

## Sample output:

`ben@nederland:~/src/aes$ ./aes`  
`I3243F6A8885A308D313198A2E0370734` Input block to encrypt  
`S328831E0435A3137F6309807A88DA234` State vector (transformed input)  
`K2B7E151628AED2A6ABF7158809CF4F3C` Key  
`O3925841D02DC09FBDC118597196A0B32` Encrypted output  
`O3243F6A8885A308D313198A2E0370734` Decrypted output (should be same as input)  
`ben@nederland:~/src/aes$`  

# References:

FIPS 197 (AES specification): [https://csrc.nist.gov/csrc/media/publications/fips/197/final/documents/fips-197.pdf]  
Rijndael S-box [https://en.wikipedia.org/wiki/Rijndael_S-box]  
Rijndael MixColumns [https://en.wikipedia.org/wiki/Rijndael_MixColumns]  
Notes on implementing AES in go: [http://blog.nindalf.com/implementing-aes/]  
X86_64 tutorial: [http://0xax.blogspot.com/2014/08/say-hello-to-x64-assembly-part-1.html]  
NASM assembler reference: [http://www.nasm.us/xdoc/2.13.01/html/nasmdoc0.html]  
GNU emacs NASM mode: [https://github.com/skeeto/nasm-mode]  
Rocksoft CRC guide (best tutorial on polynomial arithmentic): [http://ross.net/crc/download/crc_v3.txt]

In `~/.emacs`:  
`(load "~/src/nasm-mode/nasm-mode.el")`  
`(require 'nasm-mode)`  
`(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))`  

