set /p choice= "Please Select 1 for Static and 2 for DHCP:" 
IF /i "%choice%"=="1" GOTO 1
IF /i "%choice%"=="2" GOTO 2

:1
set /p IP="Please Input IP Address:"
set /p Gateway="Please Input Gateway:"
set /p DNS1="Please Input DNS:"


for /F "skip=3 tokens=1,2,3* delims= " %%G in ('netsh interface show interface') DO (
        IF "%%H"=="Connected"  netsh interface ipv4 set address name="%%J" static %IP% 255.255.255.0 %Gateway% 1 && netsh interface ipv4 set dns name="%%J" static %DNS1%
)
exit/b

:2
for /F "skip=3 tokens=1,2,3* delims= " %%G in ('netsh interface show interface') DO (
        IF "%%H"=="Connected"  netsh interface ipv4 set address name="%%J" dhcp && netsh interface ipv4 set dns name="%%J" dhcp && netsh interface ipv4 set gateway name="%%J" dhcp
)
exit/b
pause