@echo off
chcp 65001 >nul
color 0A
title Kundalik - ishga tushmoqda
cd /d "%~dp0"

echo ========================================
echo            KUNDALIK  -  START
echo ========================================
echo.

if not exist venv (
    echo [1/5] Virtual muhit yaratilmoqda...
    python -m venv venv
) else (
    echo [1/5] Virtual muhit tayyor
)

echo [2/5] venv faollashtirilmoqda...
call venv\Scripts\activate.bat

echo [3/5] Paketlar o'rnatilmoqda...
python -m pip install -q -r requirements.txt

echo [4/5] Baza tayyorlanmoqda...
python manage.py makemigrations planner
python manage.py migrate

echo [5/5] Server ishga tushmoqda...
echo.
echo ========================================
echo   Brauzerda: http://127.0.0.1:8000/
echo   To'xtatish uchun: Ctrl + C
echo ========================================
echo.
start "" http://127.0.0.1:8000/
python manage.py runserver 0.0.0.0:8000

pause
