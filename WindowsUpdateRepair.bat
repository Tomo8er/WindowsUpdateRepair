@echo off

:: �Ǘ��Ҍ����̊m�F�Ǝ擾
whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
    echo �X�N���v�g���Ǘ��҂Ƃ��Ď��s���Ă�������
    echo �Ǘ��Ҍ������擾��...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: Windows Update�T�[�r�X�̒�~
echo Windows Update�T�[�r�X���~��...
net stop wuauserv
if %errorlevel% neq 0 echo wuauserv�̒�~�Ɏ��s���܂���
net stop cryptSvc
if %errorlevel% neq 0 echo cryptSvc�̒�~�Ɏ��s���܂���
net stop bits
if %errorlevel% neq 0 echo bits�̒�~�Ɏ��s���܂���
net stop msiserver
if %errorlevel% neq 0 echo msiserver�̒�~�Ɏ��s���܂���

:: SoftwareDistribution�t�H���_�̃��l�[��
if exist C:\Windows\SoftwareDistribution (
    echo SoftwareDistribution�t�H���_�����l�[����...
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
) else (
    echo SoftwareDistribution�t�H���_��������܂���ł���
)

:: Catroot2�t�H���_�̃��l�[��
if exist C:\Windows\System32\catroot2 (
    echo Catroot2�t�H���_�����l�[����...
    ren C:\Windows\System32\catroot2 Catroot2.old
) else (
    echo Catroot2�t�H���_��������܂���ł���
)

:: Windows Update�T�[�r�X�̍ċN��
echo Windows Update�T�[�r�X���ċN����...
net start wuauserv
if %errorlevel% neq 0 echo wuauserv�̊J�n�Ɏ��s���܂���
net start cryptSvc
if %errorlevel% neq 0 echo cryptSvc�̊J�n�Ɏ��s���܂���
net start bits
if %errorlevel% neq 0 echo bits�̊J�n�Ɏ��s���܂���
net start msiserver
if %errorlevel% neq 0 echo msiserver�̊J�n�Ɏ��s���܂���

echo �������܂����B
pause
