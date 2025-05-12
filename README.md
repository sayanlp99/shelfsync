# ShelfSync: Streamlined Store Operations

## Overview

ShelfSync is a mobile application designed to simplify and streamline core operations for small to medium-sized stores. It provides cashiers with intuitive tools for managing inventory and processing point-of-sale (POS) transactions efficiently. By integrating these two crucial functionalities into a single app, ShelfSync aims to save time, reduce errors, and improve overall store management.

This project is developed as part of an assignment, fulfilling requirements such as user authentication (login/sign up) and utilizing a specified backend service.

## Key Features

* **Secure Authentication:**
    * **Login:** Allows existing users to securely access the application.
    * **Sign Up:** Enables new store staff to create accounts quickly.
    * Utilizes **Back4App's internal ParseUser object** for robust user management.
    * Implements loading indicators during backend communication for a better user experience.
* **Efficient Inventory Management:**
    * **Upload Inventory:** Easily add new products to the store's inventory with details like name, category, units, and price. Data is stored on the Back4App backend.
    * **View Inventory:** Provides a clear, real-time list of all available items fetched from Back4App.
    * **Edit Inventory:** Allows modification of existing item details, with changes persisted to Back4App.
    * **Delete Inventory:** Enables removal of items from the inventory, updating the Back4App database.
    * **State Management:** Utilizes **Provider** for efficient management and updates of inventory data, ensuring optimal performance.
* **Streamlined Point of Sale (POS):**
    * **Customer Information (Optional):** Option to record customer details for order tracking.
    * **Item Search:** Quickly find products for checkout (implementation may vary).
    * **Add to Cart:** Easily add items to a virtual shopping cart.
    * **Quantity Adjustment:** Modify the number of items in the cart.
    * **Remove from Cart:** Delete items from the current transaction.
    * **Real-time Total Calculation:** Displays the dynamically updated total amount.
    * **Checkout Process:** Simple action to finalize the sale, with order data saved to Back4App.
    * **Order History:** Access a record of past transactions retrieved from Back4App.
    * **State Management:** Employs **Provider** for effective management of the POS cart and order history, ensuring smooth UI updates.

## Architecture

ShelfSync follows a scalable and well-organized architecture:

* **Models:** Define the data structure for entities like users, inventory items, and orders.
* **Controllers:** Handle the business logic and orchestrate interactions between the UI, services, and data models.
* **Services:** Abstract the data access layer, responsible for communicating with the Back4App backend for operations like authentication, inventory management, and order processing.

This **Model-Controller-Service (MCS)** architecture promotes code modularity, maintainability, and scalability for future development.

## Backend

* **Back4App:** The application utilizes **Back4App** as its backend platform.
* **ParseUser:** Back4App's internal `ParseUser` object and its associated functions are used for managing user authentication (login, sign up, logout).
* **Data Storage:** Back4App provides a robust and scalable solution for storing all application data, including user information, inventory details, and order history.

## State Management

* **Provider:** ShelfSync leverages the **Provider** package for efficient and reactive state management. This approach is used throughout the application, particularly for:
    * Managing and displaying lists of orders.
    * Handling the state of the inventory screen.
    * Controlling the POS cart and real-time updates during transactions.

Using Provider helps to avoid common performance issues associated with simpler state management solutions like `setState` in complex screens with frequently changing data.

## Getting Started

1.  Clone the repository.
2.  Set up your Flutter environment.
3.  Configure your Back4App application ID and client key in the appropriate files.
4.  Run `flutter pub get` to install dependencies.
5.  Run the application on an emulator or physical device using `flutter run`.


