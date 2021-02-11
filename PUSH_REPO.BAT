@ECHO OFF

:AGAIN

for /f "tokens=*" %%G in ('dir /b /a:d ".\*"') do (
	ECHO %%G
	if exist files.txt del files.txt
	dir %%G\*.exe /b >> files.txt 2>NUL
	dir %%G\*.rar /b >> files.txt 2>NUL
	for %%a in (files.txt) do (
		if not %%~za == 0 (
			for /F "tokens=*" %%A in (files.txt) do (
				echo DOING: %%G\%%A
				IF NOT EXIST \BOOM\BOOM\%%G MKDIR \BOOM\BOOM\%%G > \BOOM\FROM\output.msg 2> \BOOM\FROM\output.err
				IF ERRORLEVEL 1 GOTO :EOF
				CALL :LOGGER

 				move %%G\%%A \BOOM\BOOM\%%G > \BOOM\FROM\output.msg 2> \BOOM\FROM\output.err
				IF ERRORLEVEL 1 GOTO :EOF
				CALL :LOGGER

 				cd  \BOOM\BOOM\
				IF ERRORLEVEL 1 GOTO :EOF

				git add %%G/%%A > \BOOM\FROM\output.msg 2> \BOOM\FROM\output.err
				IF ERRORLEVEL 1 GOTO :EOF
				CALL :LOGGER

 				git commit -m 'New' %%G/%%A > \BOOM\FROM\output.msg 2> \BOOM\FROM\output.err
				IF ERRORLEVEL 1 GOTO :EOF
				CALL :LOGGER

 				git push
				IF ERRORLEVEL 1 GOTO :EOF
				CALL :LOGGER

				cd \BOOM\FROM
				IF ERRORLEVEL 1 GOTO :EOF
				TIMEOUT 5
REM	CLS
			)
		)
	)
)

TIMEOUT 8800

GOTO :AGAIN

:EOF
CALL :LOGGER
ECHO ERROR
ECHO ERROR > PUSH.LOG
PAUSE
exit /b

:LOGGER
IF EXIST \BOOM\FROM\OUTPUT.MSG (
	TIME /T >> \BOOM\FROM\PUSH.LOG
	TIME /T
) ELSE (
	IF EXIST \BOOM\FROM\OUTPUT.ERR (
		TIME /T >> \BOOM\FROM\PUSH.LOG
		TIME /T
	)
)

IF EXIST \BOOM\FROM\OUTPUT.MSG (
	TYPE \BOOM\FROM\OUTPUT.MSG
	TYPE \BOOM\FROM\OUTPUT.MSG >> \BOOM\FROM\PUSH.LOG
	DEL \BOOM\FROM\OUTPUT.MSG
)
IF EXIST \BOOM\FROM\OUTPUT.ERR (
	TYPE \BOOM\FROM\OUTPUT.ERR
	TYPE \BOOM\FROM\OUTPUT.ERR >> \BOOM\FROM\PUSH.LOG
	DEL \BOOM\FROM\OUTPUT.ERR
)

EXIT /B