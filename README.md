# sorting_out_M3ERP_migration
How to sorting to compare OUT when you do migration in M3 ERP easily
When doing migration for customers in M3 ERP, I have a difficulty comparing OUT files between customer and standard components 
because MAK made them change the sorting of formats.
Those script files (config.sh; sortall.sh; eachfile.sh) use sorting 2 files of OUT objects to have the same sorting format.
How to use it?
1. Open file "config.sh"
2. Change the parameter follow the instruction in the "config.sh" file: option = 1 or 2 (1 for each file/ 2 for all files in folder)
	   + if option = 1, fill in the file name, raw file, goal file and done folder.
	   + if option = 2, fill in the raw folder, goal folder and done folder.
3. Open "MobaXterm" application, move to the folder containing 3 run files (config.sh; sortall.sh; eachfile.sh). Example: /mnt/d/Script
Then call the “sortall.sh” file  and wait to finish. Example: ./sortall.sh
 If it has any errors in the screen, please read and find why in the “eachfile.sh” file
Hope it will help you in the same case. 

Before sorting, it's difficult to compare between Product version and MVX version to get specific code:

![before_sort](https://user-images.githubusercontent.com/78299978/211595500-2652f664-4741-44c6-a4af-c968290e5237.png)


After sorted, everything is easily:

![after_sort](https://user-images.githubusercontent.com/78299978/211595578-74a93125-d7ec-4ea5-a4dd-08a36ee16c26.png)

