@echo off
cd ..

REM ��������|��t�@�C���̃p�X���w��
set TRANSLATIONS_DIR=translations\hotel_ja.ts translations\hotel_ko.ts translations\hotel_fr.ts translations\hotel_en.ts


REM lupdate�R�}���h���g�p�ł��邩�m�F
where lupdate >nul 2>nul
if %ERRORLEVEL% == 0 (
    echo lupdate�R�}���h�����p�\�ł��B�V�X�e����lupdate���g�p���܂��B
    set LUPDATE_CMD=lupdate
) else (
    REM lupdate�R�}���h��������Ȃ��ꍇ�A�l�̊��ɍ��킹����փp�X���w�肷�邱�ƁB
    echo lupdate�R�}���h��������܂���B��փp�X��lupdate���g�p���܂��B
    set LUPDATE_CMD=C:\Qt\6.5.3\msvc2019_64\bin\lupdate.exe
)

REM QML�t�@�C����C++����A�|��Ώۂ̈ꗗ���L�ڂ��ꂽts�t�@�C���𐶐�����
%LUPDATE_CMD% -recursive . -extensions qml -extensions cpp -ts %TRANSLATIONS_DIR%
REM �|��Ɋւ����񂪓��������ۂɎg����.qm�t�@�C���́ALinguist�Ń����[�X�t�@�C�����쐬���邱�ƂŐ��������

echo ���s���I�����܂����Bqm�t�@�C���́uLinguist 6.5.3 (MSVC 2019 64-bit)�v���g�p���ă����[�X�t�@�C�����쐬���Ă��������B
pause