Copy Windows spotlight images
1) Create some target directory like c:\!images
2) Copy files !copy.ps1, !schedule.bat and !silent.vbs to the c:\!images
3) Run !schedule.bat to create a windows task for daily execution. Use newly generated file "task_delete.bat" if you want to un-register the task
4) Images from the Windows spotlight cache will be daily copied to the folder c:\!images at 09:00 or later by log in
5) Configure Windows 10 background to show slide show from the folder
6) Move images you not like to "bad" folder like c:\!images\bad to be not copied from the cache more