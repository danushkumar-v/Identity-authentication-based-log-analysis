#!/bin/bash

# Identity Authentication Based Log Analysis - Quick Start Script
# This script helps you set up and run the application

set -e

echo "================================================"
echo "Identity Authentication Based Log Analysis"
echo "Quick Start Setup"
echo "================================================"
echo ""

# Check Python version
echo "Checking Python version..."
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3.7 or higher."
    exit 1
fi

PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
echo "Found Python $PYTHON_VERSION"

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo ""
    echo "Creating virtual environment..."
    python3 -m venv venv
    echo "Virtual environment created successfully!"
else
    echo ""
    echo "Virtual environment already exists."
fi

# Activate virtual environment
echo ""
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo ""
echo "Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo ""
echo "Installing dependencies..."
echo "This may take several minutes, especially for dlib and face-recognition..."
pip install -r requirements.txt

# Create necessary directories if they don't exist
echo ""
echo "Checking project structure..."
mkdir -p ImageAttendence Files

# Check if Dataset2.csv exists
if [ ! -f "Files/Dataset2.csv" ]; then
    echo "Creating Dataset2.csv..."
    echo "Name ,Date,Time" > Files/Dataset2.csv
fi

echo ""
echo "================================================"
echo "Setup Complete!"
echo "================================================"
echo ""
echo "To run the application:"
echo "  1. Activate the virtual environment (if not already active):"
echo "     source venv/bin/activate"
echo ""
echo "  2. Add face images to the ImageAttendence/ directory"
echo "     - Name files as: PersonID.jpg or PersonName.jpg"
echo ""
echo "  3. Run the application:"
echo "     streamlit run rec.py"
echo ""
echo "For detailed instructions, see INSTALLATION.md"
echo ""
echo "Would you like to start the application now? (y/n)"
read -r response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo ""
    echo "Starting the application..."
    echo "The app will open in your browser at http://localhost:8501"
    streamlit run rec.py
else
    echo ""
    echo "You can start the application later by running:"
    echo "  streamlit run rec.py"
fi
