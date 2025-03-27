# PowerShell System Monitor

![PowerShell](https://img.shields.io/badge/PowerShell-7+-blue?logo=powershell)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)

A lightweight PowerShell system monitoring tool that logs CPU and RAM usage and issues configurable alerts for performance tracking.

---

## Features
- Logs CPU and RAM usage every 30 seconds
- Saves logs as `.csv` files inside the `logs/` directory
- Shows popup alerts when CPU or RAM usage goes beyond 80%

## Configuration
Adjust settings in `config.ps1`:
- Logging interval (`$LogIntervalSeconds`)
- Thresholds (`$CPUThreshold`, `$RAMThreshold`)
- Log output directory

## How to Run
Right-click `monitor.ps1` and select "Run with PowerShell". Make sure `config.ps1` is in the same folder.

---

## Project Structure
