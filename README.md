<h1 align="center">Finance Tracker</h1>

<p align="center">
  A comprehensive finance tracking app to manage and visualize your expenses, income, and cryptocurrencies. Track categories like investments, salaries, shopping, debt payments, and monitor your cryptocurrency holdings.
</p>

## Features

- Track and visualize your expenses and income.
- Manage categories like investments, salaries, shopping, and debt payments.
- Monitor your cryptocurrency holdings.
- User-friendly interface with dynamic charts and graphs.

## Screenshots
![Screenshot 2024-08-03 at 16 26 06](https://github.com/user-attachments/assets/9b7fc2f0-55e3-43bc-a5d5-7352e0754fb6)
![Screenshot 2024-08-03 at 16 19 03](https://github.com/user-attachments/assets/b7e05488-5551-40f8-a752-707a56beb78e)

## Technologies Used

- **SwiftUI**: 
  - Leverages Apple's modern UI framework for creating user interfaces with a declarative Swift syntax, enabling dynamic and interactive layouts.

- **SwiftData**: 
  - Utilized for efficient data management and persistence, handling complex data operations and storage seamlessly.

- **Alamofire**: 
  - A robust networking library for Swift, facilitating smooth and efficient handling of network requests and API interactions.

- **Firebase**: 
  - Integrated for real-time data synchronization, user authentication, and cloud storage, providing a scalable backend solution.

## Architecture Used 
The Finance Tracker app is built using the MVVM (Model-View-ViewModel) architectural pattern. This architecture helps to separate the business logic and data handling from the user interface, making the app more modular, testable, and maintainable.

- **Model**: Represents the data and business logic of the application. It handles the data operations and communicates with external services or databases.
- **View**: The user interface of the app, responsible for displaying the data and handling user interactions.
- **ViewModel**: Acts as an intermediary between the Model and the View. It processes the data received from the Model and prepares it for display in the View, also handling user input and updating the Model accordingly.

![Screenshot 2024-08-09 at 12 31 02](https://github.com/user-attachments/assets/f79044cc-7b40-4d2f-abc1-716dd6384964)





## Installation

1. Clone this repository:

```bash
git clone https://github.com/ertekinbatuhan/finance-tracker.git

```

2. Open the project with Xcode:
```bash
open FinanceTracker.xcodeproj

```
3. Run the project.
