import os
import time
import json
import logging
import subprocess
from datetime import datetime
from win32com.client import Dispatch

# Logger configuration
logging.basicConfig(
    filename="scan_log.txt",
    level=logging.INFO,
    format="%(asctime)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)

def log_event_json(date, time, status, duration):
    # Function to register events in a JSON file
    log_entry = {
        "date": date,
        "time": time,
        "status": status,
        "duration": duration
    }
    with open("scan_log.json", "a") as log_file:
        json.dump(log_entry, log_file)
        log_file.write("\n")

def log_event_txt(message):
    # Function to register events in a text file
    logging.info(message)

def scan_with_windows_defender():
    try:
        # Execute Windows Defender scan command via command prompt
        start_time = time.time()
        start_message = "Starting quick scan via command prompt..."
        log_event_json(datetime.now().strftime("%Y-%m-%d"), datetime.now().strftime("%H:%M:%S"), start_message, 0)
        log_event_txt(start_message)
        
        command = 'powershell.exe -ExecutionPolicy Bypass -Command "Start-MpScan -ScanType QuickScan"'
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        
        end_time = time.time()
        duration = end_time - start_time

        if result.returncode == 0:
            status = "Quick scan completed successfully."
        else:
            status = f"An error occurred during the scan: {result.stderr.strip()}"

        log_event_json(datetime.now().strftime("%Y-%m-%d"), datetime.now().strftime("%H:%M:%S"), status, duration)
        log_event_txt(f"{status} Duration: {duration:.2f} seconds.")
    except Exception as e:
        error_message = f"Error during the scan: {e}"
        log_event_json(datetime.now().strftime("%Y-%m-%d"), datetime.now().strftime("%H:%M:%S"), error_message, 0)
        log_event_txt(error_message)

def main():
    while True:
        scan_with_windows_defender()
        # Wait for 5 minutes before the next scan
        time.sleep(300)

if __name__ == "__main__":
    main()
