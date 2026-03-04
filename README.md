# Waddah (وضّاح) - Educational App Frontend

## Project Overview
This is the Flutter frontend repository for the **Waddah** Arabic educational application. It is primarily built for an iOS-first responsive experience, with heavy enforcement on Arabic Right-To-Left (RTL) layouts and typography.

## Global Architectural Constraints
- **Strict RTL & Localization:** The entire app inherently respects RTL text, padding, and iconography flows through native `flutter_localizations` configurations (`ar_AE`).
- **Typography:** The app exclusively uses the modern `Cairo` typeface from Google Fonts.
- **Responsiveness:** All layouts strictly use `SafeArea`, `ConstrainedBox`, `Expanded`, and percentage-based sizing instead of rigid pixels to guarantee elegant scaling on iPads and differing iPhone models.
- **Color Theme:** 
  - Brand Purple: `#9d4edd`
  - Deep Brand Purple: `#9000FF`
  - Success Green: `#00C853`
  - Coin/Star Yellow: `#ffb703`

## Progress to Date

### 1. Authentication Screens
- **Login Screen (`login_screen.dart`):** Built to Figma spec featuring an animated gradient background. It integrates actual `FirebaseAuth.instance.signInWithEmailAndPassword` logic with Arabic snackbar error reporting.
- **Signup Screen (`signup_screen.dart`):** Features the same visually sleek design, collecting Name, Email, and Password. It implements `FirebaseAuth.instance.createUserWithEmailAndPassword` and injects the user's display name directly into the Firebase profile upon creation.
- **Password Toggles:** Added native UX interactive "eye" suffix/prefix icons to allow users to toggle password visibility.

### 2. Main Dashboard & Map
- **Interactive Dashboard (`main_dashboard.dart`):**
  - **Custom Bottom Navigation Bar:** A modern, floating navigation pod allowing seamless switching between the main Map and the Medals screen.
  - **Top HUD:** Features real-time visual hooks for User Name ('Noura Khalid' placeholder) and total collected Stars/Points.
  - **Map Nodes:** A heavily positioned, interactive node stack mimicking an RPG overworld (e.g., node 1 "Metro Ethics" unlocked in purple, while "How to navigate" locked in blue/grey).

### 3. Backend Integration
- Integrated `firebase_core` and `firebase_auth`.
- Fully configured the `google-services.json` setup for the Android variant (`com.capstone.Waddah`).
- Wired Firebase initialization natively into the `main.dart` entry loop.

## Next Steps in Roadmap
1. Develop the **Progress/Medals Screen**.
2. Flesh out the interactive logic and database hooks for unlocking map nodes.
3. Integrate Unity AR (`flutter_unity_widget`) for the Camera View.
