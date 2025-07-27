section .text
  global _start

_start:
  mov eax, 8 ;invoke sys create
  mov ebx, filename
  mov ecx, 0711o ;who can aceess
  int 0x80

  mov eax, 5 ;open
  mov ebx, filename
  mov ecx, 2 ;read-write
  mov edx, 0
  int 0x80

  mov [fd], eax ;file descriptor

  mov eax, 4 ;write
  mov ebx, [fd]
  mov ecx, message1
  mov edx, message1len
  int 0x80

append:
  mov eax, 19
  mov ebx, [fd]
  mov ecx, 0
  mov edx, 2
  int 0x80

  mov eax, 4
  mov ebx, [fd]
  mov ecx, message2
  mov edx, message2len
  int 0x80

close:
  mov eax, 6
  mov ebx, [fd]
  int 0x80

exit:
  mov eax, 1
  int 0x80

section .data
  filename db 'quotes.txt', 0h
  message1 db 'To be, or not to be, that is the question.', 10, 'A fool thinks himself to be wise, but a wise man knows himself to be a fool.', 10
  message1len equ $ - message1

  message2 db 'Better three hours too soon than a minute too late.', 10, 'No legacy is so rich as honesty.'
  message2len equ $ - message2

segment .bss
  fd resd 1