@echo off
setlocal EnableDelayedExpansion

if exist surround.txt del surround.txt

echo -                                                                                                       1         1         1
echo -   0         1         2         3         4         5         6         7         8         9         0         1         2
echo -   0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

set /A number_y = 0

set /A number_x_minus1 = 0
set /A number_x_plus1  = 0
set /A number_y_minus1 = 0
set /A number_y_plus1  = 0

set /A total_number = 0

:X_IS_0

if !number_y! LSS -9 (
rem	echo|set /p="0"
) else if !number_y! LSS 10 (
	echo|set /p="0"
)
if !number_y! LSS 100 echo|set /p="0"

echo|set /p="!number_y! "

set /A number_x = 0

:NEXT_X

set filename=r.!number_x!.!number_y!.mca



if exist !filename! (
	set /a total_number = !total_number! + 1
	echo|set /p="1"
) else (
	set /A number_x_minus1 = !number_x! - 1
	set filename=r.!number_x_minus1!.!number_y!.mca
	if exist !filename! (
		set /A number_x_plus1  = !number_x! + 1
		set filename=r.!number_x_plus1!.!number_y!.mca
		if exist !filename! (
			set /A number_y_minus1 = !number_y! - 1
			set filename=r.!number_x!.!number_y_minus1!.mca
			if exist !filename! (
				set /A number_y_plus1  = !number_y! + 1
				set filename=r.!number_x!.!number_y_plus1!.mca
				if exist !filename! (
					echo r.!number_x!.!number_y!.vox >> surround.txt
				)
			)
		)
		
	)

	echo|set /p="0"
)

set /a number_x = !number_x! + 1

if !number_x! GTR 100 (
	set /a number_y = !number_y! + 1
	if !number_y! equ 100 goto END
	echo .
	goto X_IS_0
)

goto NEXT_X
:END
echo total=!total_number!
echo .

pause