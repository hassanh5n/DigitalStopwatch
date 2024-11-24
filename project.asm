include Irvine32.inc

.data
	hours DWORD 0
	minutes DWORD 0
	seconds DWORD 0
	centisec DWORD 0

	MAX_LAPS = 10
	lapTimes DWORD MAX_LAPS DUP(?)
	lapHours DWORD MAX_LAPS DUP(?)
	lapMinutes DWORD MAX_LAPS DUP(?)
	lapSeconds DWORD MAX_LAPS DUP(?)
	lapCenti DWORD MAX_LAPS DUP(?)
    currentLap DWORD 0

	titleMsg BYTE "DIGITAL STOPWATCH", 0dh, 0ah
			 BYTE "=================", 0dh, 0ah, 0

	menuMsg BYTE "Control Options:", 0dh, 0ah
			BYTE "[S] Start/Stop", 0dh, 0ah
			BYTE "[R] Reset", 0dh, 0ah
			BYTE "[L] Lap Record (Max 10)", 0dh, 0ah
			BYTE "[V] View LAps", 0dh, 0ah
			BYTE "[Q] Quit", 0dh, 0ah, 0

	timeMsg BYTE "Time:      ", 0

	lapRecordedMsg BYTE "Lap Recorded!", 0dh, 0ah, 0
	clearStr BYTE "             ", 0dh, 0ah, 0

	lapMsg BYTE "Lap # ", 0

	colonStr BYTE ":", 0
	pressKeyMsg BYTE "Press any key to return...", 0
	isrunning byte 0
	lasttick dword 0
.code
main proc
	call clrscr
	;displaying menu
	mov edx,offset titleMsg
	call writestring
	mov edx,offset menuMsg
	call writestring 
	call crlf
	mainloop:
	mov eax,10
	call delay
	call readkey
	jz checktimer ;if no key pressed 
	cmp al,'s'
	je toggletimer
	cmp al,'r'
	je resettimer
	cmp al,'l'
	je recordlap
	cmp al,'v'
	je viewlaps
	cmp al,'q'
	je exitprog
	checktimer:
	cmp isrunning,0
	je mainloop
	invoke gettickcount
	mov ebx,eax
	sub eax,lasttick
	cmp eax,10
	jl mainloop
	mov lasttick,ebx
	inc centisec
	cmp centisec,100
	je displaytime
	mov centisec,0
	inc seconds
	cmp seconds,60
	jne displaytime
	mov seconds,0
	inc minutes
	cmp minutes,60
	jne displaytime
	mov minutes,0
	inc hours
	displaytime:
	mov dh,8
	mov dl,0
	call gotoxy
	mov edx,offset timemsg
	call writestring
	call displaycurrenttime
jmp mainloop
recordlap:
    ; Check if we can store more laps
    mov eax, currentLap
    cmp eax, MAX_LAPS
    jge mainLoop     ; Skip if maximum laps reached

    ; Store current time values in lap arrays
    mov ebx, currentLap
    mov eax, hours
    mov lapHours[ebx * 4], eax
    mov eax, minutes
    mov lapMinutes[ebx * 4], eax
    mov eax, seconds
    mov lapSeconds[ebx * 4], eax
    mov eax, centisec
    mov lapCenti[ebx * 4], eax

    ; Increment lap counter
    inc currentLap

    ; Display lap recorded message
    mov dh, 10        ; Row
    mov dl, 20        ; Column
    call Gotoxy
    mov edx, OFFSET lapRecordedMsg
    call WriteString

    ; Delay for 2 seconds
    mov ecx, 10     ; 200 * 10ms = 2 seconds
delayloop:
    mov eax, 10       ; Delay for 10ms
    call Delay
    loop delayloop

    ; Clear the lap recorded message
    mov dh, 10        ; Row
    mov dl, 20        ; Column
    call Gotoxy
    mov edx, OFFSET clearStr
    call WriteString

    jmp mainLoop

viewlaps:
    call DisplayLaps
    jmp mainLoop

toggletimer:
    xor isRunning, 1    ; Toggle running state
    jmp mainLoop

resettimer:
    mov hours, 0
    mov minutes, 0
    mov seconds, 0
    mov centisec, 0
    mov currentLap, 0   ; Reset lap counter
    jmp mainLoop

displaycurrenttime PROC
    ; Display hours
    mov eax, hours
    call WriteDec
    mov edx, OFFSET colonStr
    call WriteString

    ; Display minutes
    mov eax, minutes
    .IF eax < 10
        mov al, '0'
        call WriteChar
    .ENDIF
    mov eax, minutes
    call WriteDec
    mov edx, OFFSET colonStr
    call WriteString

    ; Display seconds
    mov eax, seconds
    .IF eax < 10
        mov al, '0'
        call WriteChar
    .ENDIF
    mov eax, seconds
    call WriteDec
    mov edx, OFFSET colonStr
    call WriteString

    ; Display centiseconds
    mov eax, centisec
    .IF eax < 10
        mov al, '0'
        call WriteChar
    .ENDIF
    mov eax, centisec
    call WriteDec
    ret
displaycurrenttime ENDP

displaylaps PROC
call clrscr
mov eax,currentlap
cmp eax,0
je nolaps

mov ecx,0
displaylaploop:
cmp ecx,currentlap
jge enddisplaylaps

mov edx,offset lapmsg
call writestring
mov eax,ecx
inc eax
call writedec
mov al,':'
call writechar
mov al,' '
call writechar

push ecx
mov ebx,ecx
mov eax,laphours[ebx*4]
call writedec
mov edx,offset colonstr
call writestring

mov eax,lapminutes[ebx*4]
.if eax < 10
    mov al,'0'
    call writechar
.endif
    mov eax,lapminutes[ebx*4]
    call writedec
    mov edx,offset colonstr
    call writestring

mov eax,lapseconds[ebx*4]
.if eax<10
    mov al,'0'
    call writechar
.endif
    mov eax,lapseconds[ebx*4]
    call writedec
    mov edx,offset colonstr
    call writestring

mov eax,lapcenti[ebx*4]
.if eax<10
    mov al,'0'
    call writechar
.endif
    mov eax,lapcenti[ebx*4]
    call writedec

call crlf
pop ecx
inc ecx
jmp displaylaploop

nolaps:
mov  edx,offset nolapsmsg
call writestring
call crlf

enddisplaylaps:
mov edx,offset presskeymsg
call writestring
call writechar

call clrscr
mov edx,offset titlemsg
call writestring
mov edx,offset menumsg
call writestring
call crlf
ret

nolapsmsg byte "no laps recorded yet",0
displaylaps endp

exitprog:
exit

main endp
 end main



