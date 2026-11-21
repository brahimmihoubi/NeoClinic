# NeoClinic 

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-^3.7.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![State Management](https://img.shields.io/badge/State%20Management-GetX%20v4.7.2-8A2BE2?style=for-the-badge)
![Storage](https://img.shields.io/badge/Storage-GetStorage-FFA000?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-4CAF50?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**Next-Generation Mobile Healthcare & Patient Experience Platform**

*A modern, reactive cross-platform mobile application delivering seamless clinical appointment scheduling, electronic health records (EHR) management, telemedicine messaging, medication tracking, and rapid emergency dispatch.*

[Features](#key-features) • [Architecture](#architecture--design-patterns) • [Project Structure](#project-structure) • [Navigation & Flow](#navigation--application-flow) • [Getting Started](#getting-started) • [Platform Configuration](#platform-configuration)

---

</div>

## Executive Summary

**NeoClinic** is a patient-centric digital healthcare ecosystem built with **Flutter** and powered by **GetX**. It addresses critical challenges in modern outpatient care by giving patients full autonomy over their clinical journey—from discovery and booking to record management and emergency support—while providing medical practices with an organized channel for patient engagement.

---

## Key Features

### 1. Authentication & Onboarding
* **Smart First-Run Detection**: Automated routing between onboarding/registration, login, and dashboard based on local session storage.
* **Phone & Credential Authentication**: Mobile-first registration and login with input validation and reactive error states.
* **OTP Verification**: Secure verification step (`/otp`) for identity confirmation and two-factor safety.
* **Persistent Session State**: Automatic authentication persistence powered by `GetStorage`.

### 2. Clinical Appointment Management
* **Interactive Booking**: Intuitive scheduling workflow to book consultations with specific physicians (`/appointmentsbooking`).
* **Categorized Schedules**: Real-time filtering between upcoming visits and past medical consultations.
* **Detailed Consult Overviews**: View doctor credentials, visit timestamps, clinical notes, and preparation instructions (`/appointmentsdetails`).

### 3. Electronic Health Records (EHR)
* **Centralized Medical Vault**: Access laboratory reports, radiology/imaging results, and clinical prescriptions in one place (`/medicalrecords`).
* **Real-Time Search & Filtering**: Instant title/type record filtering via reactive search observables.
* **Record Upload Portal**: Dedicated interface for patients to upload external medical summaries and test results (`/uploadrecords`).

### 4. Telehealth & Direct Provider Messaging
* **Consultation Chat**: Real-time conversation interface with healthcare providers and clinical staff (`/chatdetails`).
* **Message Status & History**: Visual differentiation between patient queries and physician answers with contextual timestamps.

### 5. Medication & Adherence Reminders
* **Prescription Tracking**: Active list of current medications and prescribed dosages (`/medication`).
* **Custom Reminder Schedules**: Add, configure, and dismiss scheduled alarms to foster high patient adherence.

### 6. Emergency SOS Speed-Dial
* **Instant Emergency Dispatch**: One-touch speed dialer integration connecting patients directly to emergency care (`/emergency`).
* **Native Protocol Launching**: Utilizes native platform telephony handlers via `url_launcher`.

### 7. Profile & Account Management
* **Patient Identity**: Personalized patient view with profile credentials, contact info, and medical identifiers (`/profile`).
* **Secure Logout**: Complete cache and session invalidation with safe route redirection.

---

## Architecture & Design Patterns

NeoClinic is built using the **MVC (Model-View-Controller)** pattern enhanced by **GetX Reactive State Management**:

```
┌────────────────────────────────────────────────────────┐
│                      VIEW LAYER                        │
│   (Stateless/Stateful Widgets, Screens, UI Forms)     │
└───────────────────────────▲────────────────────────────┘
                            │ (observes via Obx / GetView)
┌───────────────────────────┴────────────────────────────┐
│                   CONTROLLER LAYER                     │
│    (GetxController: Business Logic, State, Events)     │
└───────────────▲────────────────────────▲───────────────┘
                │                        │
┌───────────────┴────────┐      ┌────────┴───────────────┐
│     SERVICE LAYER      │      │      DATA MODELS       │
│ (API, GetStorage, SOS) │      │ (Dart Classes / Enums) │
└────────────────────────┘      └────────────────────────┘
```

### Key Architectural Tenets
1. **Separation of Concerns**: Views are purely declarative and decoupled from business logic; controllers handle event processing and state mutation.
2. **Reactive Observables (`Rx`)**: State variables (`.obs`) automatically notify subscribing `Obx()` widgets, eliminating unnecessary widget subtree rebuilds.
3. **Declarative Navigation**: Named routes encapsulated within `AppRoutes` and registered through `getPages` for predictable deep linking and route guards.
4. **Dependency Injection**: Centralized dependency lifecycle management via `InitialBindings` and `Get.put()` ensures singletons and on-demand controllers are initialized cleanly without boilerplate.
5. **Harmonized Design System**: Centralized design tokens located in `AppColors`:
   * **Primary Brand Blue**: `#2F80ED`
   * **Light Background**: `#F2F7FF`
   * **Error / Urgent**: `#D32F2F`
   * **Neutral Dark / Typography**: `#000000` & `#6E7A8A`

---

## Project Structure

```text
neoclinic/
├── frontend/
│   ├── android/                     # Native Android platform code and manifests
│   ├── ios/                         # Native iOS platform configuration & Pods
│   ├── web/                         # Web build runners & index.html
│   ├── macos/ | linux/ | windows/   # Desktop platform integrations
│   ├── lib/
│   │   ├── assets/
│   │   │   └── images/              # Local icons, brand assets, and logos
│   │   ├── bindings/
│   │   │   └── initial_binding.dart # Global dependency injection setup
│   │   ├── constants/
│   │   │   └── app_colors.dart      # Application color palette and design tokens
│   │   ├── controllers/             # GetX business logic & state management
│   │   │   ├── appointment_controller.dart
│   │   │   ├── authcontroller.dart
│   │   │   ├── chatdetailscontroller.dart
│   │   │   ├── emergencycontroller.dart
│   │   │   ├── homepagecontroller.dart
│   │   │   ├── medicalrecordscontroller.dart
│   │   │   ├── medicationcontroller.dart
│   │   │   ├── otpcontroller.dart
│   │   │   ├── profilecontroller.dart
│   │   │   ├── registrationcontroller.dart
│   │   │   └── splashcontroller.dart
│   │   ├── models/                  # Plain Dart data models
│   │   │   ├── appointment_model.dart
│   │   │   ├── medicalrecords_model.dart
│   │   │   └── message_model.dart
│   │   ├── routes/                  # Navigation routes and screen bindings
│   │   │   ├── app_routes.dart      # Route string constants
│   │   │   └── app_screens.dart     # GetPage definitions and bindings
│   │   ├── services/                # Local persistence & external data clients
│   │   │   ├── api_service.dart     # HTTP / REST endpoint service
│   │   │   ├── appointment_service.dart
│   │   │   └── storage_services.dart# GetStorage wrapper for persistent keys
│   │   ├── views/                   # UI Screens & Page Layouts
│   │   │   ├── appointments_screen.dart
│   │   │   ├── appointmentsbooking_screen.dart
│   │   │   ├── appointmentsdetails_screen.dart
│   │   │   ├── chatdetails_screen.dart
│   │   │   ├── emergency_screen.dart
│   │   │   ├── homepage_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── medicalrecords_screen.dart
│   │   │   ├── medication_screen.dart
│   │   │   ├── otp_screen.dart
│   │   │   ├── profile_screen.dart
│   │   │   ├── recordsdetails_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── splash_screen.dart
│   │   │   └── uploadrecords_screen.dart
│   │   ├── widgets/                 # Reusable custom UI components
│   │   │   ├── appointment_card.dart
│   │   │   ├── header_widget.dart
│   │   │   ├── loading_widget.dart
│   │   │   ├── logo_widgets.dart
│   │   │   └── sectioncard_widget.dart
│   │   └── main.dart                # Application entry point & service bootstrap
│   ├── test/                        # Unit and widget tests
│   ├── pubspec.yaml                 # Package dependencies and asset declarations
│   └── analysis_options.yaml        # Static code analysis and lint rules
└── README.md
```

---

## Navigation & Application Flow

```mermaid
flowchart TD
    Start([App Launch]) --> Splash[Splash Screen]
    
    Splash --> Decision{Session Check}
    Decision -- First Time -- Register[Registration Screen]
    Decision -- Logged In -- Home[Home Dashboard]
    Decision -- Unauthenticated -- Login[Login Screen]
    
    Register --> OTP[OTP Verification]
    OTP --> Home
    Login --> Home
    
    Home --> Appointments[Appointments Hub]
    Home --> Records[Medical Records]
    Home --> Chat[Telehealth Chat]
    Home --> Medication[Medication Tracker]
    Home --> Emergency[Emergency SOS]
    Home --> Profile[Patient Profile]
    
    Appointments --> Book[Book Appointment]
    Appointments --> ApptDetails[Appointment Details]
    Records --> RecordDetails[Record Details]
    Records --> Upload[Upload Record]
    Profile --> Logout([Logout / Invalidate]) --> Login
```

---

## Tech Stack & Core Libraries

| Technology / Package | Version | Purpose |
| :--- | :--- | :--- |
| **Flutter SDK** | `>=3.7.0` | Cross-platform UI toolkit |
| **Dart** | `>=3.7.0 <4.0.0` | Client-optimized programming language |
| **get** | `^4.7.2` | High-performance state management, dependency injection & routing |
| **get_storage** | `^2.1.1` | Ultra-fast synchronous key-value local persistent storage |
| **url_launcher** | `^6.3.1` | Native URL, email, and telephonic intent launcher |
| **cupertino_icons** | `^1.0.8` | iOS-styled iconography |
| **flutter_lints** | `^5.0.0` | Recommended static analysis and style guide enforcement |

---

## Getting Started

### Prerequisites
* **Flutter SDK**: `^3.7.0` ([Installation Guide](https://docs.flutter.dev/get-started/install))
* **Dart SDK**: Compatible with Flutter version
* **IDE**: Android Studio, Visual Studio Code (with Flutter/Dart extensions), or IntelliJ IDEA
* **Emulators / Devices**: Android Emulator (API 30+) or iOS Simulator (iOS 15+)

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/neoclinic.git
   cd neoclinic/frontend
   ```

2. **Install project dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter environment:**
   ```bash
   flutter doctor
   ```

4. **Launch the application:**
   ```bash
   # Run on connected device or default emulator
   flutter run

   # Target specific platform
   flutter run -d chrome      # Web
   flutter run -d android     # Android
   flutter run -d ios         # iOS
   ```

---

## Platform Configuration

### Android Setup
To allow the emergency module (`EmergencyController`) to dial emergency numbers through native telephone dialers, ensure your `frontend/android/app/src/main/AndroidManifest.xml` includes intent queries:

```xml
<queries>
    <intent>
        <action android:name="android.intent.action.DIAL" />
        <data android:scheme="tel" />
    </intent>
</queries>
```

### iOS Setup
For iOS, add the required URL scheme support in `frontend/ios/Runner/Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>tel</string>
</array>
```

---

## Testing & Code Quality

Maintain high code standards using Flutter's built-in tooling:

```bash
# Navigate to the frontend workspace
cd frontend

# Run static code analysis
flutter analyze

# Run unit and widget tests
flutter test

# Automatically format code according to Dart conventions
dart format .
```

---

## Roadmap

- [ ] **Cloud Backend Integration**: Connect to production REST/GraphQL or Firebase Firestore endpoints.
- [ ] **Push Notifications**: Cloud messaging for scheduled appointment alerts and medication intake alarms.
- [ ] **Biometric Authentication**: Secure fingerprint / FaceID unlocking for instant access.
- [ ] **Integrated Video Consultations**: WebRTC-powered telemedicine video calls.
- [ ] **Prescription OCR / AI Summary**: Automated extraction of medications from uploaded lab/prescription photos.

---

## Contributing

Contributions to NeoClinic are welcome!
1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## License

Distributed under the **MIT License**. See `LICENSE` for more information.

---

<div align="center">
  <sub>Developed for modern healthcare delivery.</sub>
</div>
