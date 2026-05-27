# DayScore: Next-Gen AI Wellness Ecosystem

[![Flutter](https://img.shields.io/badge/Flutter-3.24%2B-02569B?logo=flutter&style=flat-square)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Functions-FFCA28?logo=firebase&style=flat-square)](https://firebase.google.com/)
[![OpenAI](https://img.shields.io/badge/OpenAI-GPT--4o--mini-41ADFF?logo=openai&style=flat-square)](https://openai.com/)
[![Architecture](https://img.shields.io/badge/Architecture-Clean--MVVM-success?style=flat-square)]()
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)

DayScore is a premium, AI-driven wellness platform engineered to bridge the gap between physical health and psychological well-being. By integrating real-time biometric data with advanced Natural Language Processing (NLP), DayScore provides a predictive, 360-degree view of user health, empowering data-backed lifestyle optimization.

---

## 🌌 Core Philosophy

Modern productivity often ignores the "Human Factor." DayScore leverages a **Predictive Wellness Model** to forecast energy levels and burnout risks before they manifest, transforming the user from a reactive participant into a proactive architect of their own health.

## 🚀 Key Value Propositions

### 🤖 Intelligent Coaching
Powered by **OpenAI GPT-4o-mini**, the AI Wellness Coach processes user biometric trends and journal sentiment to provide hyper-personalized habit recommendations and motivational support.

### 📊 Dynamic Biometric Dashboard
Full-stack synchronization with **Health Connect (Android)** and **HealthKit (iOS)**. Tracks steps, sleep cycles, heart rate variability, and caloric expenditure in a unified, glassmorphic UI.

### 🧠 Emotional Intelligence Engine
Utilizes **VADER Sentiment Analysis** to quantify emotional trends from daily journal entries, correlating psychological state with physical activity to generate a holistic **Wellness Score (0-100)**.

---

## 🛠️ Engineering Stack

### Frontend Architecture
- **Framework**: Flutter 3.24+ (Impeller-optimized)
- **State Management**: Riverpod 2.x (Reactive/Declarative)
- **Navigation**: GoRouter (Type-safe routing)
- **Design System**: Material 3 with Custom **Glassmorphism** Theme Extensions
- **Visuals**: Flutter Animate, Lottie, Rive, FL Chart

### Backend & AI Infrastructure
- **Infrastructure**: Firebase (Auth, Firestore, Messaging, Analytics)
- **AI Engine**: OpenAI API, Python FastAPI (VADER NLP Service)
- **Cloud Logic**: Firebase Functions (Node.js/Python)

---

## 🏗️ Project Structure (Clean Architecture)

```text
lib/
├── core/               # Global configurations (Theme, Router, Constants)
├── features/           # Domain-driven feature modules
│   ├── auth/           # Firebase Authentication & Session Management
│   ├── dashboard/      # Real-time data visualization
│   ├── mood/           # Psychological state tracking
│   ├── chatbot/        # AI Coach (OpenAI Integration)
│   └── journal/        # NLP-based reflective journaling
├── services/           # Infrastructure wrappers (AI, Health, Firebase)
├── widgets/            # Reusable Atomic UI components
└── app.dart            # Root application configuration
```

---

## 📥 Getting Started

### Prerequisites
- Flutter SDK `3.24.0` or higher
- Firebase Project with Firestore and Auth (Email/Google) enabled
- OpenAI API Key

### Installation

1. **Clone & Install**
   ```bash
   git clone https://github.com/your-username/dayscore.git
   cd dayscore
   flutter pub get
   ```

2. **Firebase Setup**
   - Place `google-services.json` in `android/app/`
   - Place `GoogleService-Info.plist` in `ios/Runner/`
   - Apply Firestore Security Rules (see `security_rules.txt`)

3. **Environment Configuration**
   - Inject your OpenAI API key in `lib/features/chatbot/presentation/chatbot_providers.dart` or via a `.env` file.

4. **Execution**
   ```bash
   flutter run --release
   ```

---

## 🛤️ Roadmap

- [x] **Phase 1-3**: Core Architecture & Futuristic UI Framework
- [x] **Phase 4**: OpenAI Chatbot & Basic Journaling Integration
- [/] **Phase 5**: Health Connect Real-time Sync & ML Prediction Engine
- [ ] **Phase 6**: Community Gamification & Counselor Booking System
- [ ] **Phase 7**: End-to-End Encryption for Sensitive Data

---

## 🔒 Security & Compliance

- **Data Sovereignty**: Local-first caching with optional Firebase synchronization.
- **GDPR Compliance**: Built-in mechanisms for Right to Access and Right to Erasure.
- **Protocol**: 256-bit AES encryption for biometric data transit.

---
*Developed as a Next-Generation Wellness Solution.*
