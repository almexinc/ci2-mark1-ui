@echo off
cd ..

REM 生成する翻訳ファイルのパスを指定
set TRANSLATIONS_DIR=translations\hotel_ja.ts translations\hotel_ko.ts translations\hotel_fr.ts translations\hotel_en.ts


REM lupdateコマンドが使用できるか確認
where lupdate >nul 2>nul
if %ERRORLEVEL% == 0 (
    echo lupdateコマンドが利用可能です。システムのlupdateを使用します。
    set LUPDATE_CMD=lupdate
) else (
    REM lupdateコマンドが見つからない場合、個人の環境に合わせた代替パスを指定すること。
    echo lupdateコマンドが見つかりません。代替パスのlupdateを使用します。
    set LUPDATE_CMD=C:\Qt\6.5.3\msvc2019_64\bin\lupdate.exe
)

REM QMLファイルとC++から、翻訳対象の一覧が記載されたtsファイルを生成する
%LUPDATE_CMD% -recursive . -extensions qml -extensions cpp -ts %TRANSLATIONS_DIR%
REM 翻訳に関する情報が入った実際に使われる.qmファイルは、Linguistでリリースファイルを作成することで生成される

echo 実行が終了しました。qmファイルは「Linguist 6.5.3 (MSVC 2019 64-bit)」を使用してリリースファイルを作成してください。
pause