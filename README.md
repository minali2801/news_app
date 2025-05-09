# Flutter News App

## Description

The **Flutter News App** is a simple yet powerful news application built using Flutter. The app allows users to browse through news articles from various sources, bookmark their favorite articles, and view the full content in a WebView. It supports features like login, a news feed, bookmarking functionality, and persistence of bookmarked articles even after the app is closed. The app also provides dark mode support and pull-to-refresh functionality for a better user experience.

## Features

=> 1. Login Page
- **Email and password fields**: Allows users to input email and password for login.
- **Login button**: Users can log in after entering the correct credentials.
- **Validation**: Ensures required fields are filled and validates the email format.
- **No backend connection**: Login is local and does not require backend integration.
- **Login session persistence**: Users don’t need to log in every time they open the app.

=> 2. News Feed Page
- Fetches news from a publicly available News API (using `http` or `Dio`).
- Displays articles with:
  - **Thumbnail image**
  - **Title**
  - **Description**
  - **Source name**
  - **Published Date**: Dates are displayed in the format **[16 April, 2025]**.
- **WebView**: Users can tap on an article to see the full content in a WebView.
- **Bookmark button**: Users can save articles for later access.

=> 3. Bookmarks Page
- Displays a list of all saved articles.
- **Remove articles from bookmarks**: Users can remove articles from their bookmarks.
- **Persistence**: Bookmarked articles are saved locally and persist even after the app is closed.

=> 4. Navigation
- **Tab Bar**: Easy navigation between the News Feed page and the Bookmarks page.

### Optional Features
- **Pull-to-refresh**: Allows users to refresh the news feed by pulling down.
- **Dark Mode**: Switch between light and dark themes for a better user experience.

## Setup Instructions

   1.Clone the repository**:
   git clone https://github.com/minali2801/news_app.git
   2.Install dependencies:
   flutter pub get
   3.Run the app:
   Connect a device or start an emulator, and run:flutter run

## Screenshots
   Here are some screenshots of the app:
   1.News Feed Page

   2.Bookmark Page

   3.WebView Page  

   4.Login page

## Architecture Choices
   State Management: The app uses Provider for managing the state of news articles and bookmarks.
   Persistence: Bookmarked articles are saved using SharedPreferences to persist data across app restarts.
   API: News articles are fetched from a publicly available News API using the http or Dio package for making API requests.
   UI: The app follows Material Design for building the UI, ensuring a consistent and modern look.

## Third-Party Packages Used
   1.http: For making API calls to fetch news articles.
   2.provider: For state management of bookmarks and news articles.
   3.shared_preferences: To persist bookmarked articles across sessions.
   4.flutter_webview_plugin: To display full article content in a WebView.
   5.google_fonts: For adding custom fonts to the app.
   6.intl: For formatting dates in a readable format.
   7.email_validator: ^3.0.0
   8.custom_refresh_indicator: ^4.0.1

## APK and Walkthrough Video
   APK File:https://drive.google.com/file/d/1Htjjo_lHc6b8ijCIStYi7FmTdliIep9o/view?usp=sharing
## screnshots
   ## 📸 Screenshots

### 🔐 Login Screen  
![Login Screen](screenshots/loginPage.png)

### 📰 News List  
![News List](screenshots/newsList.jpg)

### 📄 Article Details  
![Article Details](screenshots/webview.jpg) etc.....

## License : MIT License