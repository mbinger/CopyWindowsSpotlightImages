Copy Windows spotlight images - Powershell edition
1) Create some target directory like c:\!images
2) Copy files copy.ps1, schedule.bat, silent.vbs and config.json to the c:\!images
3) Write images destination path to the config.json like "outputPath": "c:\\Users\\MyUser\\YandexDisk\\wallpapers" or leave the file default to use current execution directory as output path
4) Run schedule.bat to create a windows task for daily execution. Use newly generated file "task_delete.bat" if you want to un-register the task
5) Images from the Windows spotlight cache will be daily copied to the folder c:\!images at 09:00 or later by log in
6) Configure Windows 10 background to show slide show from the folder
7) Move images you not like to "bad" folder like c:\!images\bad to be not copied from the cache more