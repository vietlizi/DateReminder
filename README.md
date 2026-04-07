# Date Reminder
A high-pressure countdown tool for students who want to experience professional-grade anxiety every time they look at their Mac.

## Overview
Built in Swift during the peak of procrastination-induced productivity, this app ensures you never forget how little time you have left before exams or project deadlines. 

## Key Features
* Precision Countdown: Track your remaining time in Days, Hours, and Minutes.
* Bilingual Support: Full English and Vietnamese localization with an instant toggle.
* Dynamic Status Bar: Choose between displaying Percentage, Days, or Detailed time directly in the macOS menu bar.
* Smart Percentage: Progress is calculated starting from Jan 1st of the event year to give you the big picture of your suffering.
* Persistence: Your custom events are saved locally so they will not disappear when you restart.
* Integrated Pomodoro: A built-in focus timer with live menu bar syncing to help you actually get to work.

## Installation
1. Download the latest DMG from [Releases](https://github.com/whooslizi/DateReminder/releases).
2. Drag DateReminder.app to your Applications folder.
3. Launch the app and enjoy your newly acquired PTSD responsibly.

## Build It Yourself
If you prefer working the hard way:
```bash
git clone [https://github.com/whooslizi/DateReminder.git](https://github.com/whooslizi/DateReminder.git)
cd DateReminder
xcodebuild -scheme "DateReminder" -configuration Release
