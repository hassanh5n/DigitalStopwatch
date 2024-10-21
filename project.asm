INCLUDE Irvine32.inc

.code
main PROC

mov eax, 5
mov ebx, 10
call dumpregs

exit
main ENDP
END main