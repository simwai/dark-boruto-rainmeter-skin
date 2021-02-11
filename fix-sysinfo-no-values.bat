if _%1_==_payload_  goto :payload

:getadmin
    echo %~nx0: elevating self
    set vbs=%temp%\getadmin.vbs
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%"
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof

:payload
    echo %~nx0: running payload with parameters:
    echo %*
    echo ---------------------------------------------------
    cd /d %2
    shift
    shift
    rem put your code here
    reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT

    if %OS% == 32BIT (
        cd c:\windows\system32
        lodctr /R
    )

    if %OS% == 64BIT (
        cd c:\windows\sysWOW64
        lodctr /R
    )

    pause
    goto :eof

