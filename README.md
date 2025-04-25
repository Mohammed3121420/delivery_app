#Overview
This is a Flutter application that allows users to log in using an API and stores data locally using SQLite. The app also features data filtering and automatically logs the user out after two minutes of inactivity.

##Key Features
-Login: The app uses an API to validate user data (User ID, Password, and Language).

-Local Storage: Data is stored locally in SQLite, making the app usable offline.

-Data Filtering: The app allows filtering of stored data using SQL queries.

-Automatic Logout: After two minutes of inactivity, the user is automatically logged out.

##Design Choices
-Local Storage with SQLite: SQLite was chosen for local data storage to ensure offline access.

-API Interaction: The app uses an API to log in and validate the user.

-State Management with Provider: Provider is used for state management, facilitating interaction between the frontend and backend.
