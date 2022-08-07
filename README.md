# Charger

Login Screen & Profile Screen
Status bar is setted to light content regardless of device theme. Thus, user always sees the status bar in white color.

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-17 at 23 54 24](https://user-images.githubusercontent.com/3129441/179424377-808d7318-d6e6-49b7-8c4c-98285abe2fb0.gif)

Login Screen Wrong Entry for Email

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-17 at 23 56 03](https://user-images.githubusercontent.com/3129441/179424442-d92e69fe-0889-4372-9647-966848a84f74.gif)

Search City and Station List

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 00 12 40](https://user-images.githubusercontent.com/3129441/179424995-0911f8cf-eec2-46ea-a577-9df24c5c993c.gif)

Wrong Search in City Selection Screen

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 00 14 22](https://user-images.githubusercontent.com/3129441/179425039-bdfdfb01-ffb9-4dfc-aa9e-09860e9a53ad.gif)

City Selection 
If city does not have a station , then search bar and filter button disables in station selection screen. 

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 00 16 04](https://user-images.githubusercontent.com/3129441/179425090-80f0eb44-0c7e-4449-a61e-3661f4c2c12e.gif)

Station Selection 

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 00 22 46](https://user-images.githubusercontent.com/3129441/179425287-96ee1e2e-a19f-457c-b07b-7dc4d422e199.gif)

Show & Delete Appointments
I haven't implemented create appointment screen yet, because of this I created appointment with my device id and user ID in postman and tested it in similator to see appointments in screen. When user press delete button , appointment is deleted from screen and server(I checked it from postman to see deletion from server).

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 00 57 01](https://user-images.githubusercontent.com/3129441/179426293-5fce1fc3-5343-4dbb-8e8e-54cdb3dcf7db.gif)

After appointment time has passed , appointment will be shown in past appointments. Delete button is not shown to user in passed appointments.

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 01 02 08](https://user-images.githubusercontent.com/3129441/179426553-6477eee9-453e-49c8-bda9-40797e4a7272.gif)

If user does not give location permission, then kilometer info is not shown to user in station list and list order is not according to kilometers. Otherwise station list will be shown increasing order according to kilometers.

![Simulator Screen Recording - iPhone 13 Pro - 2022-07-18 at 01 07 14](https://user-images.githubusercontent.com/3129441/179426700-3ba11754-a443-41e2-ae2b-7a7716186c73.gif)

Charger is written by using MVVM pattern. 
Every screen has a module in project. 
Each module has own endpoint in network layer.
Because of time limit I could not finish time and date selection, appointment detail and filter screens.
Because of my bad luck, my file was deleted in the last 1 hour of deadline, i had to deal with the deleted codes ( I learned something in here, I have to always push my codes to my repository :) ), I just took the screenshots and wrote this readme file after midnight, sorry for it. But I pushed my codes before midnight. Thanks for your understanding.

After deadline the project's missing screens are done. You can see them in the below.
![Simulator Screen Recording - iPhone 13 Pro - 2022-07-26 at 17 00 42](https://user-images.githubusercontent.com/3129441/183301829-06d02c66-b407-44e9-9b8a-547374727ba7.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-07-26 at 17 02 33](https://user-images.githubusercontent.com/3129441/183301844-b5550e31-3304-4847-8f3b-966231157721.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-08-03 at 15 16 16](https://user-images.githubusercontent.com/3129441/183301892-b4032023-0e63-4c6d-bee2-ad2c509fc6cd.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-08-03 at 15 17 30](https://user-images.githubusercontent.com/3129441/183301909-b90635ae-29f5-4c60-b05f-0bfa38ee4359.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-08-03 at 15 18 26](https://user-images.githubusercontent.com/3129441/183301922-142d1ec3-a44e-43e4-8f1c-f410b30b9269.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-08-03 at 15 58 50](https://user-images.githubusercontent.com/3129441/183301930-384e6cab-0f9a-4c27-8412-11f9cd3f45fa.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-08-06 at 03 21 16](https://user-images.githubusercontent.com/3129441/183302060-46a0b438-9596-4370-9a36-4ed59c7c31cc.gif)
![Simulator Screen Recording - iPhone 13 Pro - 2022-08-07 at 13 07 46](https://user-images.githubusercontent.com/3129441/183302098-b6ece9e9-708d-47ed-8563-81dd9a53cadd.gif)


