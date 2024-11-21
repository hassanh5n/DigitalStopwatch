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

mloop
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
je mloop

invoke gettickcount
mov ebx,eax
sub eax,lasttick
cmp eax,10
jl mloop

mov lasttick,ebx

inc centisec
cmp centisec,100
je displaytime

mov centisec,0
inc seconds
cmp seconds,60
jne displaytime

mov second,0
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

jmp mloop