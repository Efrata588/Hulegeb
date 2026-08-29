# Hulegeb 🛒

A modern E-Commerce Flutter application built for a class project, integrating with a public REST API for product catalog, user authentication, and shopping cart management.

## 🚀 Features

- **Product Catalog**: Fetch, view, and search products with real-time filtering.
- **User Authentication**: Secure user login using token storage.
- **Cart Management**: Add, update, remove items, and manage shopping carts.
- **User Profile**: View and edit user details.

## 🌐 Public API

Powered by [FakeStoreAPI](https://fakestoreapi.com):
- Base URL: `https://fakestoreapi.com`
- Endpoints used: `/products`, `/carts`, `/users`, `/auth/login`

## 🛠️ Tech Stack & Dependencies

- **Framework**: Flutter & Dart
- **State Management**: Riverpod (`flutter_riverpod`)
- **Networking**: Dio (`dio`)
- **Routing**: Go Router (`go_router`)
- **Storage**: `flutter_secure_storage` & `shared_preferences`

## ⚡ Getting Started

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```
