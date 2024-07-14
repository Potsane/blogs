# Blogs App.

This simple Flutter App allows users to view and create blogs. This code base demonstrates using SOLID principles and their application with Clean Architecture. The app uses `Bloc & Cubit` for State Management, `Get-it` for Dependency Injection, `Hive` for Local Persistence and `Supabase` for serverless cloud functions.

## LIBRARIES USED

- [Bloc](https://bloclibrary.dev/) & Cubit - For handling and manipulating state, it provides a seamless approach to state management.
- [Get-it](https://pub.dev/packages/get_it) - A powerful package for managing dependencies.
- [Hive](https://docs.hivedb.dev/#/) - Local storage management.

# Illustrations (Android & iOS)
<img src = "https://github.com/user-attachments/assets/e6dead5a-7603-483e-989d-96c3e5e879d2" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/f9deaa17-7ab6-456e-9917-f6057f085166" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/d9bff77f-fae8-4f59-9d58-7d6237d5b932" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/962ccf55-97d3-45a3-b8fe-fec028c2fccf" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/35424810-201c-4d24-abdc-3753892de496" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/74990602-a703-48f6-8e77-2bf368565dd3" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/b1be0fc6-c99b-4914-a320-2a48de2761cd" width="250" height = "500">&emsp;
<img src = "https://github.com/user-attachments/assets/79e188d9-8595-44a4-82fb-629ec876dc14" width="250" height = "500">&emsp;

## Architecture

The application follows a Layered Clean Architecture with a simple Unidirectional Flow of Data. The code is categorized into 3 Logical Layers, Presentation, Domain and Data Laters. 
`The Presentation Layer` is responsible for handling the UI, this is where we have the Flutter Widgets and the Bloc State Holders
`The Domain Layer` contains the Business Logic of the app, it contains Usecases and Repository interfaces. 
`The Data Layer` provides access to Remote data sources and Local storage. This is where the Repository implementations sit.

<img width="928" alt="Screenshot 2024-07-14 at 23 27 07" src="https://github.com/user-attachments/assets/7443fc7d-60dd-48e3-8fec-120367725d6e">



