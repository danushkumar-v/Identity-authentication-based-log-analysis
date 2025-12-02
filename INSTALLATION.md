# Installation and Usage Guide

## Identity Authentication Based Log Analysis

This guide will help you install and run the Identity Authentication Based Log Analysis tool, which uses facial recognition for real-time authentication and attendance tracking.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Project Structure](#project-structure)
4. [Configuration](#configuration)
5. [Running the Application](#running-the-application)
6. [Usage](#usage)
7. [Troubleshooting](#troubleshooting)

---

## Prerequisites

Before installing the application, ensure you have the following:

### System Requirements

- **Operating System**: Windows, macOS, or Linux
- **Python**: Version 3.7 or higher (3.8+ recommended)
- **Webcam**: Required for live face recognition
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: At least 2GB free space

### System Dependencies

#### For Ubuntu/Debian Linux:
```bash
sudo apt-get update
sudo apt-get install -y python3-pip python3-dev
sudo apt-get install -y cmake
sudo apt-get install -y libsm6 libxext6 libxrender-dev
sudo apt-get install -y libopencv-dev python3-opencv
```

#### For macOS:
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install cmake
brew install opencv
```

#### For Windows:
- Install [Visual C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/)
- Install [CMake](https://cmake.org/download/)

---

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/danushkumar-v/Identity-authentication-based-log-analysis.git
cd Identity-authentication-based-log-analysis
```

### Step 2: Create a Virtual Environment (Recommended)

Creating a virtual environment helps isolate project dependencies:

#### On Linux/macOS:
```bash
python3 -m venv venv
source venv/bin/activate
```

#### On Windows:
```bash
python -m venv venv
venv\Scripts\activate
```

### Step 3: Upgrade pip

```bash
pip install --upgrade pip
```

### Step 4: Install Dependencies

```bash
pip install -r requirements.txt
```

**Note**: Installing dlib and face-recognition may take some time, especially on the first installation. This is normal.

#### Troubleshooting Installation Issues:

If you encounter issues installing `dlib`:

**For Linux:**
```bash
sudo apt-get install build-essential cmake
sudo apt-get install libopenblas-dev liblapack-dev
pip install dlib
```

**For macOS:**
```bash
brew install cmake
pip install dlib
```

**For Windows:**
Download pre-compiled dlib wheel from [here](https://github.com/sachadee/Dlib) and install:
```bash
pip install dlib-19.22.0-cp39-cp39-win_amd64.whl
```

---

## Project Structure

```
Identity-authentication-based-log-analysis/
│
├── rec.py                          # Main Streamlit application
├── requirements.txt                # Python dependencies
├── data.db                         # SQLite database (auto-generated)
│
├── ImageAttendence/               # Directory for training images
│   ├── person1.jpg
│   ├── person2.jpg
│   └── ...
│
├── Files/                         # Data storage
│   └── Dataset2.csv              # Attendance logs
│
├── functions/                     # Core functionality modules
│   ├── imgprocessing.py          # Image processing functions
│   ├── webcam.py                 # Webcam handling
│   ├── encoding.py               # Face encoding
│   ├── detect.py                 # Face detection
│   └── add.py                    # Add attendance records
│
└── App_functions/                # Application-specific functions
    └── webfun.py                 # Web interface utilities
```

---

## Configuration

### Step 1: Prepare Training Images

1. Create face images for each person you want to recognize
2. Save images in the `ImageAttendence/` directory
3. **Important naming convention**: Name each file as `PersonID.jpg` or `PersonName.jpg`
   - Example: `20AD003.jpg`, `JohnDoe.jpg`
   - The filename (without extension) will be used as the person's identifier

**Image Guidelines:**
- Use clear, front-facing photos
- Good lighting conditions
- Only one face per image
- Supported formats: `.jpg`, `.jpeg`, `.png`
- Recommended resolution: 640x480 or higher

### Step 2: Initialize the Dataset

The `Files/Dataset2.csv` file stores attendance logs. If it doesn't exist, create it with the following header:

```csv
Name ,Date,Time
```

**Note**: There's a space after "Name" - this is intentional and part of the original design.

---

## Running the Application

### Start the Application

```bash
streamlit run rec.py
```

The application will automatically open in your default web browser at `http://localhost:8501`

### Alternative: Specify Port

```bash
streamlit run rec.py --server.port 8080
```

---

## Usage

### 1. Live Video Stream

This feature enables real-time face recognition and attendance logging.

**How to use:**
1. From the dropdown menu, select **"Live video stream"**
2. Allow browser access to your webcam when prompted
3. The system will:
   - Detect faces in real-time
   - Match them against the trained images
   - Display the person's name on the video feed
   - Automatically log attendance with timestamp

**Attendance Logging Rules:**
- First detection of the day is logged as "IN" time
- Subsequent detections (after 5 minutes) are logged
- Last detection is considered "OUT" time

### 2. Log Analysis

This feature provides attendance analytics and reporting.

#### Overall Analysis

Select **"Overall"** to view:
- **Daily Summary**: Present and absent counts for today
- **Trend Chart**: Absentee count over time
- **Date-specific Absentee List**: Select any date to see who was absent

#### By Person Analysis

Select **"By person"** to view individual statistics:
- **Daily Metrics**:
  - IN time
  - OUT time
  - Total time spent
  
- **Overall Statistics**:
  - Total working days
  - Days present
  - Days absent
  - Present/Absent ratio (pie chart)
  - Late entry vs. on-time entry comparison

**Note**: "Late entry" is defined as arrival after 08:45:00

---

## Troubleshooting

### Common Issues and Solutions

#### 1. Webcam Not Working

**Issue**: "No camera detected" or black screen

**Solutions**:
- Ensure webcam is connected and not being used by another application
- Check browser permissions for camera access
- On Linux, add user to video group:
  ```bash
  sudo usermod -a -G video $USER
  ```

#### 2. Face Not Recognized

**Issue**: Face detected but not recognized

**Solutions**:
- Ensure training image exists in `ImageAttendence/` directory
- Verify image filename matches expected format
- Try using a different, clearer image
- Ensure good lighting conditions during recognition

#### 3. Module Import Errors

**Issue**: `ModuleNotFoundError` when running the application

**Solutions**:
- Verify virtual environment is activated
- Reinstall requirements:
  ```bash
  pip install -r requirements.txt --force-reinstall
  ```

#### 4. CMake or dlib Installation Fails

**Issue**: Error during `pip install -r requirements.txt`

**Solutions**:
- Install system dependencies (see Prerequisites section)
- For Windows, use pre-compiled wheels
- Ensure you have sufficient RAM (close other applications)

#### 5. Port Already in Use

**Issue**: "Port 8501 is already in use"

**Solutions**:
```bash
# Use a different port
streamlit run rec.py --server.port 8502

# Or kill the process using the port (Linux/macOS)
lsof -ti:8501 | xargs kill -9

# Windows
netstat -ano | findstr :8501
taskkill /PID <PID> /F
```

#### 6. Encoding Errors in CSV

**Issue**: CSV file reading errors

**Solutions**:
- Ensure `Dataset2.csv` uses UTF-8 encoding
- Verify CSV header matches: `Name ,Date,Time`
- Check for special characters in names

#### 7. Performance Issues

**Issue**: Slow face recognition or lag

**Solutions**:
- Reduce webcam resolution in `functions/detect.py` (line 5)
- Limit number of faces to recognize
- Close other resource-intensive applications
- Consider using a more powerful machine

---

## Advanced Configuration

### Custom Late Entry Time

To change the late entry threshold (default: 08:45:00), edit `App_functions/webfun.py`, line 70:

```python
if str(j) >= "08-45-00":  # Change this time
```

### Custom Attendance Interval

To change the minimum time between attendance logs (default: 5 minutes), edit `functions/add.py`, line 21:

```python
if(str(min_time) > "0:05:00"):  # Change this interval
```

### Using IP Camera

To use an IP camera instead of local webcam, edit `functions/webcam.py`, lines 15-17:

```python
address = "http://192.168.1.12:8080/video"  # Your IP camera URL
cap.open(address)
```

---

## Data Management

### Backup Attendance Data

Regular backups are recommended:

```bash
# Backup CSV file
cp Files/Dataset2.csv Files/Dataset2_backup_$(date +%Y%m%d).csv

# Backup database
cp data.db data_backup_$(date +%Y%m%d).db
```

### Export Data

The attendance data in `Files/Dataset2.csv` can be opened with:
- Microsoft Excel
- Google Sheets
- Any CSV-compatible application

### Clear Data

To start fresh (this will delete all attendance records):

```bash
# Backup first!
cp Files/Dataset2.csv Files/Dataset2_backup.csv

# Reset the file
echo "Name ,Date,Time" > Files/Dataset2.csv
```

---

## Support and Contributing

### Getting Help

- **Issues**: Report bugs on [GitHub Issues](https://github.com/danushkumar-v/Identity-authentication-based-log-analysis/issues)
- **Questions**: Start a discussion on [GitHub Discussions](https://github.com/danushkumar-v/Identity-authentication-based-log-analysis/discussions)

### Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## License

This project is available for educational and research purposes.

---

## Acknowledgments

- Face recognition powered by [face_recognition](https://github.com/ageitgey/face_recognition) library
- Built with [Streamlit](https://streamlit.io/)
- Uses [OpenCV](https://opencv.org/) for image processing

---

## Version History

- **v1.0** - Initial release with basic face recognition and attendance logging
- **v1.1** - Added comprehensive documentation and fixed path issues

---

**Last Updated**: December 2025
