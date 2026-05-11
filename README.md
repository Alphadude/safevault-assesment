# SafeVault - Secure Authentication Module

SafeVault is a production-ready Flutter application focusing on a highly secure and polished Authentication Module. It follows **Clean Architecture** principles and utilizes **Riverpod** for robust state management.

## 🚀 Key Features

### 🔐 Security & Logic
*   **Brute-Force Protection**: Implements a lockout mechanism that triggers after 5 failed login attempts, enforcing a 60-second cooldown period.
*   **Secure Backend Simulation**: Mocked repository layer with async delays to simulate real-world Node.js API latency.
*   **Robust Form Validation**: 
    *   Strict email format verification.
    *   Password strength requirements (8+ characters, uppercase, digit, and special character).
*   **Password Visibility Toggle**: Secure input field with a toggle to show/hide the password.

### 🎨 UI/UX & Design
*   **Responsive & Adaptive**: Fully responsive layout built with `LayoutBuilder` and proportional `Spacer` widgets, ensuring a perfect fit on any screen size.
*   **Non-Scrollable Layout**: A clean, fixed-viewport design that remains stable even when the keyboard is active.
*   **High-Contrast Light Theme**: A premium "Black on White" aesthetic for maximum readability and a modern feel.
*   **Custom Branding**: Integrated custom shield logo as the app icon and as an asset within the app.
*   **Premium Typography**: Uses **Inter** (Google Fonts) for a crisp, professional look.

### 🏗 Architecture
*   **Clean Architecture**: Separated into **Domain** (Business Logic), **Data** (Models/Repos), and **Presentation** (UI/State) layers.
*   **State Management**: Managed via **Riverpod** (`StateNotifierProvider`), ensuring unidirectional data flow and easy testability.

## 🧪 Testing Suite
The project includes a comprehensive suite of tests to ensure stability:
*   **Unit Tests**: Located in `test/features/auth/presentation/providers/auth_notifier_test.dart`. Covers all state transitions (Initial, Loading, Success, Error, Lockout).
*   **Widget Tests**: Located in `test/features/auth/presentation/screens/login_screen_test.dart`. Verifies UI component presence and form validation logic.
*   **Mocking**: Utilizes **Mocktail** for clean, dependency-free mocking of the repository layer.

## 🛠 Tech Stack
*   **Framework**: Flutter (Material 3)
*   **State Management**: Riverpod
*   **Functional Programming**: Dartz (for Either/Failure handling)
*   **Typography**: Google Fonts (Inter)
*   **Testing**: Mocktail, flutter_test
*   **Icons/Assets**: flutter_launcher_icons

## 📦 Getting Started

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/Alphadude/safevault-assesment.git
    ```
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run tests**:
    ```bash
    flutter test
    ```
4.  **Run the app**:
    ```bash
    flutter run
    ```

---
*Developed by Antigravity - Senior Full-Stack Mobile Engineer.*
