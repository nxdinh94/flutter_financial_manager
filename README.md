# Personal Finance Management App

## Introduction
This is a Flutter-based application designed to help users track their income, expenses, and overall financial health. The app provides intuitive financial insights and an easy-to-use interface for better money management.

## Features
- Add, edit, and delete income and expense transactions.
- Categorize transactions by predefined or custom categories.
- View detailed financial reports (daily, monthly, yearly).
- Interactive charts for financial analysis.

## Technologies Used
- **Flutter** (latest version)
- **State Management**: Provider
- **Database**: Nodejs, Mongodb, JWT

## Installation & Setup
Ensure you have Flutter SDK installed before proceeding.

### Steps to Run the App:
```sh
# Clone the repository
git clone <https://github.com/nxdinh94/UI_DACS3.git>
cd <UI_DACS3>

# Install dependencies
flutter pub get

# Run the application
flutter run
```

## Project Structure
```
lib/
|-- constant/      
|-- models/    
|-- pages
|-- providers/   
|-- utils
|-- widgets  
```

## Một số giao diện của ứng dụng
### Home Screen
![Image](assets/screen_app/home.jpg)
### Transaction History
![Image](assets/screen_app/transaction_history.jpg)
### Add Expense
![Image](assets/screen_app/adding_workspace.jpg)
### Expense Limit Details
![Image](assets/screen_app/budgets.jpg)

## Contribution & Development
We welcome contributions! To contribute:
1. Fork the repository.
2. Create a new branch.
3. Make changes and commit them.
4. Submit a pull request.

## Contact
For any questions or issues, feel free to reach out:
- **Email**: [nguyenxuandinh336@gmail.com]
- **GitHub**: [https://github.com/nxdinh94]



## Push notifications
## isolate
## Testing
## Work with Dio
## Provider -> RiverPod
## Native module
## Caching data


// something need to refactor
1. Transform data of get budget into model
2. fix bug check picked category in addingworkspace
3. fix api url createIconCategories


--Warm: update category chir làm phần expense, ch có tg làm income

# Shared_preferences keys
-- {mode, user, accessToken, appData, refreshToken}