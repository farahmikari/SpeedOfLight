
# ⭐ Speed of Light — E-Commerce Mobile Application

An e-commerce Flutter application that provides a complete shopping experience with a clean and modern interface.

![logo_SpeedOfLight](https://github.com/user-attachments/assets/cb45672b-081f-45da-95fb-75a0473ec4b2)

______________________________________________________________

## 🚀 Features

1. Create an account and log in  
2. View and update user profile information (including profile image)  
3. View all available stores  
4. Browse all products inside each store  
5. View detailed product information  
6. Search for a store  
7. Search for products inside a specific store  
8. Add products to the cart with quantity control and automated price updates  
9. After completing the payment, all orders move to the Purchases section  
10. View all past purchases with quantity and date  
11. Add products to your Favorites list  
12. Logout  

______________________________________________________________

## 🛠️ Flutter & Dart Version

Your environment must meet the following minimum requirements:

  dart: ">=3.8.0-0 <4.0.0"
  flutter: ">=3.24.0"
  
______________________________________________________________

## 🧩 State Management & Local Storage

This project uses:

- **Provider** for state management  
- **Shared Preferences** for local data persistence (saving user info, tokens, etc.)

______________________________________________________________

## 📦 Installation and Run Project
   ```bash
   # clone project
   git clone https://github.com/farahmikari/SpeedOfLight.git

   # Navigate into the project
   cd SpeedOfLight

   # Install dependencies
   flutter pub get

   # Run flutter application
   flutter run   
   ```
______________________________________________________________

## 🖥️ Backend framework

Laravel 11

______________________________________________________________

## 🔗 Backend Setup
The backend source code is available here in **master** branch  :
https://github.com/FarahRam04/SpeedOfLight.git

To run the backend project :
  ```bash
  # clone project 
  git clone -b master https://github.com/FarahRam04/SpeedOfLight.git

  # Navigate into the project
  cd SpeedOfLight

  # Install dependencies
  composer install

  # Generate application key
  php artisan key:generate

  # Run database migrations
  php artisan migrate

  # Create the environment file (The `.env` file is not included in the repository for security reasons.)
  cp .env.example .env
   # Open the newly created .env file and update the following values
   APP_URL=http://127.0.0.1:8000
   DB_DATABASE=your_database_name
   DB_USERNAME=your_username
   DB_PASSWORD=your_password

  # Run migrations + seed database
  php artisan migrate:fresh --seed

  # Link storage Folder
  php artisan storage:link

  # Start the Laravel development server
  php artisan serve
  ```
______________________________________________________________

## 🔗 API Base URL
  ```bash
  # update the flutter app baseURL in class Api 
  http://127.0.0.1:8000/api

  # update image in class Api
  http://127.0.0.1:8000/storage/images/

  ```
______________________________________________________________
