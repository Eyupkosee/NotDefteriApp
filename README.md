<div align="left" style="position: relative;">
<img src="https://raw.githubusercontent.com/PKief/vscode-material-icon-theme/ec559a9f6bfd399b82bb44393651661b08aaf7ba/icons/folder-markdown-open.svg" align="right" width="30%" style="margin: -20px 0 0 20px;">
<h1>NOTDEFTERIAPP</h1>
<p align="left">
	<img src="https://img.shields.io/github/license/Eyupkosee/NotDefteriApp?style=default&logo=opensourceinitiative&logoColor=white&color=6b9adc" alt="license">
	<img src="https://img.shields.io/github/last-commit/Eyupkosee/NotDefteriApp?style=default&logo=git&logoColor=white&color=6b9adc" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/Eyupkosee/NotDefteriApp?style=default&color=6b9adc" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/Eyupkosee/NotDefteriApp?style=default&color=6b9adc" alt="repo-language-count">
</p>
</div>
<br clear="right">

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

NotDefteriApp is a task management application built with SwiftUI that helps users organize and track their todos. The app integrates with Firebase for user authentication and data storage, offers task statistics, and features a clean, modern UI with customizable task colors.

---

## Features

- User authentication (login, registration, password reset)
- Create, read, update, and delete tasks
- Task categorization with custom colors
- Task statistics and performance tracking
- Profile management
- Push notifications for task reminders
- Splash screen animation

---

## Project Structure

```sh
└── NotDefteriApp/
    ├── NotDefteriApp
    │   ├── App
    │   ├── Assets.xcassets
    │   ├── GoogleService-Info.plist
    │   ├── Helpers+Extensions
    │   ├── Models
    │   ├── Preview Content
    │   ├── ViewModels
    │   └── Views
    ├── NotDefteriApp.xcodeproj
    └── README.md
```

The project follows the MVVM (Model-View-ViewModel) architecture:
- **Models**: Data structures (Task.swift, User.swift)
- **Views**: User interface components organized by feature
- **ViewModels**: Business logic handling data manipulation and user actions
- **Helpers+Extensions**: Utility functions and SwiftUI extensions

---

## Getting Started

### Prerequisites

- macOS (latest stable version recommended)
- Xcode 13.0 or later
- iOS 15.0+ target deployment
- Swift 5.5+
- Apple Developer account (for testing on physical devices)

### Installation

1. Clone the NotDefteriApp repository:
```sh
git clone https://github.com/Eyupkosee/NotDefteriApp
```

2. Navigate to the project directory:
```sh
cd NotDefteriApp
```

3. Open the project in Xcode:
```sh
open NotDefteriApp.xcodeproj
```

4. Install dependencies using Swift Package Manager:

The project uses the following dependencies that will be automatically installed when opening the project:
- **Firebase**: Authentication and Firestore database
- **Lottie**: Animation framework for splash screen
- **Charts**: Data visualization for statistics view

To manually add these dependencies if needed:
- In Xcode, go to File > Add Packages
- Add the following package URLs:
  - Firebase: https://github.com/firebase/firebase-ios-sdk
  - Lottie: https://github.com/airbnb/lottie-ios
  - Charts: https://github.com/ChartsOrg/Charts

5. Add your own `GoogleService-Info.plist`:
- Create a Firebase project at [firebase.google.com](https://firebase.google.com)
- Register your iOS app with your bundle identifier
- Download the GoogleService-Info.plist file
- Drag and drop the file into your Xcode project (make sure to check "Copy items if needed")

### Usage

1. Select your target device or simulator in Xcode
2. Build and run the project (⌘+R)
3. Register a new account or use the demo account:
   - Email: demo@example.com
   - Password: demo123

---

## Contributing

- **🐛 [Report Issues](https://github.com/Eyupkosee/NotDefteriApp/issues)**: Submit bugs found or log feature requests
- **💡 [Submit Pull Requests](https://github.com/Eyupkosee/NotDefteriApp/pulls)**: Contribute your improvements to the project

---

## License

This project is protected under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.

---
