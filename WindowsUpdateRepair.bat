@echo off

:: 管理者権限の確認と取得
whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
    echo スクリプトを管理者として実行してください
    echo 管理者権限を取得中...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: Windows Updateサービスの停止
echo Windows Updateサービスを停止中...
net stop wuauserv
if %errorlevel% neq 0 echo wuauservの停止に失敗しました
net stop cryptSvc
if %errorlevel% neq 0 echo cryptSvcの停止に失敗しました
net stop bits
if %errorlevel% neq 0 echo bitsの停止に失敗しました
net stop msiserver
if %errorlevel% neq 0 echo msiserverの停止に失敗しました

:: SoftwareDistributionフォルダのリネーム
if exist C:\Windows\SoftwareDistribution (
    echo SoftwareDistributionフォルダをリネーム中...
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
) else (
    echo SoftwareDistributionフォルダが見つかりませんでした
)

:: Catroot2フォルダのリネーム
if exist C:\Windows\System32\catroot2 (
    echo Catroot2フォルダをリネーム中...
    ren C:\Windows\System32\catroot2 Catroot2.old
) else (
    echo Catroot2フォルダが見つかりませんでした
)

:: Windows Updateサービスの再起動
echo Windows Updateサービスを再起動中...
net start wuauserv
if %errorlevel% neq 0 echo wuauservの開始に失敗しました
net start cryptSvc
if %errorlevel% neq 0 echo cryptSvcの開始に失敗しました
net start bits
if %errorlevel% neq 0 echo bitsの開始に失敗しました
net start msiserver
if %errorlevel% neq 0 echo msiserverの開始に失敗しました

echo 完了しました。
pause
