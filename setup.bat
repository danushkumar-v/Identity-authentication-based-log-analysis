@echo off
REM Identity Authentication Based Log Analysis - Quick Start Script for Windows
REM This script helps you set up and run the application

echo ================================================
echo Identity Authentication Based Log Analysis
echo Quick Start Setup (Windows)
echo ================================================
echo.

REM Check Python version
echo Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo Error: Python is not installed or not in PATH.
    echo Please install Python 3.7 or higher from https://www.python.org/
    pause
    exit /b 1
)

python --version
echo.

REM Create virtual environment if it doesn't exist
if not exist "venv\" (
    echo Creating virtual environment...
    python -m venv venv
    echo Virtual environment created successfully!
) else (
    echo Virtual environment already exists.
)
echo.

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate.bat

REM Upgrade pip
echo.
echo Upgrading pip...
python -m pip install --upgrade pip

REM Install requirements
echo.
echo Installing dependencies...
echo This may take several minutes, especially for dlib and face-recognition...
pip install -r requirements.txt

REM Create necessary directories if they don't exist
echo.
echo Checking project structure...
if not exist "ImageAttendence\" mkdir ImageAttendence
if not exist "Files\" mkdir Files

REM Check if Dataset2.csv exists
if not exist "Files\Dataset2.csv" (
    echo Creating Dataset2.csv...
    echo Name ,Date,Time > Files\Dataset2.csv
)

echo.
echo ================================================
echo Setup Complete!
echo ================================================
echo.
echo To run the application:
echo   1. Activate the virtual environment (if not already active):
echo      venv\Scripts\activate.bat
echo.
echo   2. Add face images to the ImageAttendence\ directory
echo      - Name files as: PersonID.jpg or PersonName.jpg
echo.
echo   3. Run the application:
echo      streamlit run rec.py
echo.
echo For detailed instructions, see INSTALLATION.md
echo.
set /p response="Would you like to start the application now? (y/n): "

if /i "%response%"=="y" (
    echo.
    echo Starting the application...
    echo The app will open in your browser at http://localhost:8501
    streamlit run rec.py
) else if /i "%response%"=="n" (
    echo.
    echo You can start the application later by running:
    echo   streamlit run rec.py
) else (
    echo.
    echo Invalid response. You can start the application later by running:
    echo   streamlit run rec.py
)

pause
