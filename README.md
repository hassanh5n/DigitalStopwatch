
# Digital Stopwatch

This project is a digital stopwatch implemented in **x86 assembly language**, leveraging the Irvine32 library. It provides basic stopwatch functionalities such as starting, stopping, resetting, recording laps, and viewing lap times.

Made by:
1. Hassan Nafees          `23K-0769`
2. Aaqib Al Amin Shivji   `23K-0625`
3. Syed Suhaib Raza       `23K-0621`

---

## Features
- **Start/Stop**: Toggle the stopwatch between running and paused states.
- **Reset**: Reset the stopwatch to zero.
- **Lap Recording**: Record up to 10 lap times during a session.
- **Lap Viewing**: View all recorded lap times in a user-friendly format.
- **Pause Display**: Clearly indicates when the stopwatch is paused.

---

## Requirements
1. **Assembler**: MASM32 or compatible assembler.
2. **Libraries**: 
   - `Irvine32.inc`
   - `win32.inc`
   - `kernel32.lib`
3. **Hardware**: x86-compatible CPU.
4. **Environment**: A Windows-based system with a command-line interface.

---

## Program Structure

### **Data Section**
- Stopwatch time components: `hours`, `minutes`, `seconds`, `centisec`.
- Lap data storage arrays: `lapTimes`, `lapHours`, `lapMinutes`, `lapSeconds`, `lapCenti`.
- User interface messages for menu options, lap recording, and pause notifications.

### **Code Section**
- **Main Functionality**:
  - Displays the user interface and processes key inputs for operations.
- **Time Tracking**:
  - Uses `QueryPerformanceCounter` and `QueryPerformanceFrequency` for high-precision timing.
- **Display**:
  - Dynamically updates the stopwatch display and lap records on the console.
- **Procedures**:
  - `displaycurrenttime`: Outputs the current stopwatch time.
  - `recordlap`: Saves the current time to lap arrays.
  - `viewlaps`: Displays all recorded laps.
  - `toggletimer`: Starts or stops the stopwatch.
  - `resettimer`: Resets the stopwatch and clears laps.

---

## User Instructions
1. **Compile and Run**:
   - Assemble and run the program using MASM in VS Studio 

2. **Controls**:
   - **S**: Start/Stop the stopwatch.
   - **R**: Reset the stopwatch and clear laps.
   - **L**: Record the current stopwatch time as a lap.
   - **V**: View all recorded laps.
   - **Q**: Quit the program.

3. **Display**:
   - The current time is displayed in the format: `HH:MM:SS:CC`.
   - Lap times are displayed in the same format with the lap number.

---

## Limitations
- Supports a maximum of 10 laps per session.
- The program runs on Windows environments only, as it relies on the Irvine32 library and specific Windows APIs.

---

## Acknowledgments
- **Irvine Library**: Simplifying low-level programming tasks.
- **QueryPerformanceCounter/QueryPerformanceFrequency**: Enabling high-precision timing.
