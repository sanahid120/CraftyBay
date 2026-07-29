# CraftyBay - Flutter E-Commerce Project

CraftyBay is a modern e-commerce application built with Flutter, demonstrating a clean architecture approach and advanced mobile features. This is an **individual project** developed to showcase professional Android development patterns and intelligent user assistance.

## 🚀 Key Features

- **Secure OTP Authentication**: Complete user authentication flow using One-Time Passwords (OTP).
- **OTP Resend Timer**: Integrated countdown timer on the verification screen to manage resend requests and improve user experience.
- **AI-Powered In-App Chat**: Integrated AI model providing an intelligent conversational assistant for real-time user support and product inquiries.
- **REST API Integration**: Robust communication with backend services using a standardized RESTful API layer.
- **Multi-Language Support**: Support for English and Bangla languages with automatic persistence across sessions.
- **Theme Customization**: Support for Light and Dark modes that remember user preference using local storage.

## 🏗 Architecture & Design

The project follows **Clean Architecture** principles to ensure the codebase remains scalable, maintainable, and testable.
- **Layered Structure**: Separation of concerns across Data, Domain, and Presentation layers.
- **State Management**: Powered by **Provider** for efficient and reactive UI updates.
- **Networking**: Custom `NetworkCaller` service for centralized REST API handling with standardized response parsing.

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Networking**: REST API via `http` package.
- **Persistence**: `SharedPreferences` for user settings (Theme, Language, Auth).
- **AI**: Integrated AI model for the conversational assistant.

## 💳 Payment Integration

- **bKash**: Secure mobile financial service integration for streamlined payment processing.

## 🤖 AI Integration

- **In-App Assistant**: A conversational AI interface built directly into the app, allowing users to interact with an AI model for instant assistance, helping resolve queries without leaving the application.

## 📝 Project Scope & Notes

- **Individual Effort**: This project was conceived and developed entirely by a single developer (not a team project).
- **Current Implementation**: Focuses on Authentication, Category/Product Browsing, AI Chat Assistant, and bKash Payment.
- **Non-Implemented Features**: Please note that **Cart** and **Favorite (Wishlist)** functionalities are currently **not** implemented in this version.
