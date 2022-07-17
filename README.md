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

