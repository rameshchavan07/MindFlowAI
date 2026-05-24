---
title: DayScore AI Wellness Platform
version: 1.1
author: "[Your Name]"
date: 2026-05-24
status: Draft — MVP Scoping
---

# FINAL MASTER PROMPT — DAYSCORE AI WELLNESS PLATFORM

You are a senior full-stack architect, Flutter expert, Firebase engineer, AI/ML engineer, UI/UX designer, DevOps engineer, and startup product designer.

Build a production-ready AI-powered wellness and productivity mobile application named **DayScore**.

The application should combine:
- AI wellness assistance
- Productivity tracking
- Mood analysis
- Mental wellness
- Real-time fitness tracking
- Machine learning predictions
- Counselor booking
- Community gamification
- Advanced analytics

The final product should feel like a premium modern Android startup application similar to:
- Google Fit
- Headspace
- Calm
- Notion
- Duolingo

---

## Table of Contents

1. [Project Goal](#project-goal)
2. [Tech Stack](#tech-stack)
3. [Modern UI/UX Design System](#modern-uiux-design-system)
4. [Color System](#color-system)
5. [UI Components](#ui-components)
6. [Required Screens](#required-screens)
7. [Authentication System](#authentication-system)
8. [Health & Fitness Integration](#health--fitness-integration)
9. [Dashboard Features](#dashboard-features)
10. [Mood Tracking System](#mood-tracking-system)
11. [AI Wellness Chatbot](#ai-wellness-chatbot)
12. [Daily Journal + NLP Analysis](#daily-journal--nlp-analysis)
13. [Machine Learning Wellness Prediction](#machine-learning-wellness-prediction)
14. [Counselor Booking System](#counselor-booking-system)
15. [Community & Gamification](#community--gamification)
16. [Analytics & Insights](#analytics--insights)
17. [Notification System](#notification-system)
18. [Firebase Database Design](#firebase-database-design)
19. [App Architecture](#app-architecture)
20. [Security & Privacy Compliance](#security--privacy-compliance)
21. [Performance Optimization](#performance-optimization)
22. [Modern Animations](#modern-animations)
23. [Typography](#typography)
24. [Responsive Design](#responsive-design)
25. [Error Handling Strategy](#error-handling-strategy)
26. [Testing](#testing)
27. [DevOps & Deployment](#devops--deployment)
28. [Documentation Required](#documentation-required)
29. [Advanced Features](#advanced-features)
30. [Coding Standards](#coding-standards)
31. [Output Format & Build Phases](#output-format--build-phases)
32. [Cost Estimates](#cost-estimates)
33. [Final Expectation](#final-expectation)

---

## PROJECT GOAL

Build a scalable AI-powered wellness ecosystem suitable for:
- Final year engineering project
- Resume showcase
- Internship portfolio
- Startup MVP
- Production deployment
- App Store / Play Store release

The app must include:
- Beautiful futuristic Android UI
- Real-time fitness integration
- AI-powered insights
- Machine learning wellness prediction
- Modern animations
- Secure cloud architecture

---

## TECH STACK

### Frontend
- Flutter 3.24+
- Dart 3.5+
- Riverpod 2.x
- GoRouter 14.x
- Material 3
- Responsive UI

### Backend & Cloud
- Firebase Authentication (primary auth — no custom JWT)
- Cloud Firestore
- Firebase Storage
- Firebase Cloud Messaging
- Firebase Analytics
- Firebase Functions (Node.js or Python)

### AI & Machine Learning
- Python 3.11+
- scikit-learn 1.x
- FastAPI 0.110+
- VADER Sentiment Analysis (via `vaderSentiment`)
- OpenAI API (GPT-4o-mini for chatbot)

### APIs & Integrations
- Google Fit API / Apple HealthKit (via `health` Flutter package)
- Jitsi Meet SDK (video consultations)

---

## MODERN UI/UX DESIGN SYSTEM

Design the app with:
- Premium Android flagship UI
- Glassmorphism (layered on top of Material 3 theme)
- Soft neon gradients
- Smooth animations
- Minimal futuristic layouts
- Dynamic dashboards
- AI-inspired visual design

The UI should feel:
- Modern
- Clean
- Futuristic
- Highly interactive
- Startup-quality

> **Note**: Build a custom ThemeExtension layer on top of Material 3 to achieve the glassmorphism/neon aesthetic without fighting the M3 framework defaults.

---

## COLOR SYSTEM

Primary Colors:
- Lime Green
- Emerald Green
- Cyan
- Purple
- Dark backgrounds

Dark Theme Colors:
- `#0F172A` (deep navy)
- `#111827` (dark charcoal)
- `#1E293B` (slate)

Accent Colors:
- Lime: `#A3E635`
- Cyan: `#22D3EE`
- Purple: `#8B5CF6`

Use:
- Gradient cards
- Glow effects
- Glass blur widgets
- Transparent containers

---

## UI COMPONENTS

Implement:
- Floating bottom navigation
- Animated cards
- Circular wellness rings
- Interactive charts
- Smooth transitions
- AI floating assistant button
- Skeleton loaders
- Pull-to-refresh
- Swipe gestures
- Hero animations

---

## REQUIRED SCREENS

Build:
1. Splash Screen
2. Onboarding (3–4 pages)
3. Login / Register
4. Home Dashboard
5. Mood Tracker
6. Journal Screen
7. AI Chatbot
8. Analytics Screen
9. Community Screen
10. Counselor Booking
11. Profile Screen
12. Settings Screen

> **Wireframes**: Before implementation, create low-fidelity wireframes (Figma or hand-drawn) for each screen documenting layout, navigation flow, and key interaction points.

---

## AUTHENTICATION SYSTEM

Implement using **Firebase Authentication** (no custom JWT/session layer):
- Email/password login
- Google Sign-In
- Forgot password
- Secure logout
- User onboarding flow
- Firebase ID token–based session management

User profile fields (stored in Firestore `users` collection):
- Name
- Age
- Gender
- Wellness goals
- Stress level (baseline)
- Sleep target (hours)
- Fitness target (steps/calories)
- Work/study type

**Acceptance Criteria**:
- [ ] User can register with email/password and see the onboarding flow
- [ ] User can sign in via Google in under 3 seconds
- [ ] Forgot password email is delivered within 30 seconds
- [ ] Profile data persists across sessions
- [ ] Unauthorized users cannot access any screen beyond login

---

## HEALTH & FITNESS INTEGRATION

Integrate real-time fitness tracking using the **`health`** Flutter package (wraps both Google Fit and Apple HealthKit).

**Packages**:
- `health` (unified Google Fit + HealthKit wrapper)
- `permission_handler`

**Data Points to Fetch**:
- Steps count
- Calories burned
- Heart rate
- Sleep duration
- Workout activity
- Hydration tracking
- Distance walked
- Active minutes
- BMI
- Oxygen saturation

**Display data in**:
- Dashboard widgets
- Analytics charts
- Wellness prediction input
- AI insight context

**Implementation Requirements**:
- OAuth 2.0 authentication flow for Google Fit
- Real-time syncing (foreground)
- Background sync (periodic, battery-efficient)
- Offline caching with sync-on-reconnect
- Token refresh handling

**Future Support (v2)**:
- Fitbit API
- Samsung Health
- Garmin Connect

**Acceptance Criteria**:
- [ ] Steps, calories, and heart rate display on dashboard within 5 seconds of opening
- [ ] Data syncs in background every 15 minutes
- [ ] App works offline with last-cached health data
- [ ] User can revoke health permissions from Settings

---

## DASHBOARD FEATURES

Create a futuristic dashboard showing:
- Wellness score (composite 0–100)
- Live steps counter
- Mood tracker quick-entry
- Sleep analytics summary
- Heart rate monitor
- Productivity graph
- Water intake tracker
- AI recommendations card
- Habit streaks

Include:
- Animated progress rings
- Live charts (auto-refresh)
- Expandable widgets
- Real-time updates via Firestore streams

---

## MOOD TRACKING SYSTEM

Implement:
- Emoji mood selector
- Mood intensity slider (1–10)
- Mood notes (free text)
- Mood history timeline
- Weekly mood heatmap

Mood categories:
- Happy
- Calm
- Stressed
- Sad
- Angry
- Excited
- Tired

Store all data in Firestore `moods` collection with timestamp, userId, category, intensity, and notes.

**Acceptance Criteria**:
- [ ] User can log a mood in under 5 seconds (3 taps max)
- [ ] Mood history shows scrollable timeline of last 30 days
- [ ] Weekly heatmap renders correctly with color-coded intensities
- [ ] Mood entries sync to Firestore within 2 seconds

---

## AI WELLNESS CHATBOT

Build an AI-powered wellness assistant with:
- Productivity guidance
- Wellness coaching
- Habit building advice
- Stress management techniques
- Daily affirmations
- Motivational conversations

Requirements:
- OpenAI API integration (GPT-4o-mini)
- Chat history stored in Firestore
- Suggested prompt chips
- Typing indicator animation
- Voice input support (speech-to-text)
- Dark/light mode support

> **Safety**: The chatbot must never provide medical diagnosis, prescribe medication, or replace professional mental health advice. Include a visible disclaimer on the chat screen.

**Acceptance Criteria**:
- [ ] AI responds within 3 seconds on average
- [ ] Chat history persists across sessions
- [ ] Suggested prompts appear on first open
- [ ] Disclaimer is visible at the top of every chat session
- [ ] Voice input converts to text and sends as a message

---

## DAILY JOURNAL + NLP ANALYSIS

Implement:
- Rich text journaling
- Voice-to-text journaling
- Emotion tagging (manual)
- Journal entry history (searchable)

**AI Processing (VADER Sentiment Analysis)**:
- Sentiment scoring (positive / neutral / negative)
- Compound sentiment score (-1.0 to +1.0)
- Positivity percentage per entry

Use the **`vaderSentiment`** Python package:
```python
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
analyzer = SentimentIntensityAnalyzer()
scores = analyzer.polarity_scores(journal_text)
# Returns: {'neg': 0.0, 'neu': 0.3, 'pos': 0.7, 'compound': 0.85}
```

Analytics:
- Emotional trend line (7-day, 30-day)
- Weekly wellness report (auto-generated)
- Mood-vs-journal correlation insights

**Acceptance Criteria**:
- [ ] Journal entry saves to Firestore with sentiment scores attached
- [ ] Sentiment analysis completes within 1 second per entry
- [ ] User can search past journal entries by keyword
- [ ] Voice-to-text input works offline (on-device STT)

---

## MACHINE LEARNING WELLNESS PREDICTION

Build ML models using scikit-learn.

**Input Features**:
- Sleep hours
- Water intake (glasses)
- Mood score (from mood tracker)
- Exercise duration (minutes)
- Productivity score (self-reported)
- Screen time (hours)
- Stress level (1–10)
- Journal sentiment compound score
- Heart rate average
- Daily step count

**Output**:
- Predicted next-day wellness score (0–100)

**Training Data Strategy**:
- **Cold start**: Use synthetic data generated from wellness research correlations (e.g., sleep 7–9h → higher wellness) to bootstrap the model
- **Warm up**: After 14+ days of user data, retrain a personalized model per user
- **Public datasets**: Supplement with Kaggle wellness/fitness datasets for initial validation
- **Minimum sample size**: 50 entries before enabling predictions for a user

**Requirements**:
- Regression model (Random Forest or Gradient Boosting)
- Model serialization using `joblib`
- FastAPI endpoint serving predictions
- Flutter integration via HTTP POST

**Display**:
- Predicted score with confidence interval
- Burnout risk indicator (if predicted score < 40 for 3+ consecutive days)
- AI-generated improvement recommendations
- 7-day wellness forecast chart

**Acceptance Criteria**:
- [ ] Model achieves MAE < 10 on validation set
- [ ] Prediction API responds within 500ms
- [ ] Burnout warning triggers correctly when threshold is met
- [ ] User sees "Not enough data" message if < 14 days of entries

---

## COUNSELOR BOOKING SYSTEM

Implement:
- Counselor profiles (photo, bio, specializations, credentials)
- Ratings and reviews
- Availability calendar
- Session booking with confirmation
- Push notification reminders (30 min before session)
- Video consultation via **Jitsi Meet SDK**
- Booking history

**Jitsi Integration**:
- Use the `jitsi_meet_flutter_sdk` package
- Generate unique room IDs per booking
- Enable audio/video toggle
- Support chat within video call

**Acceptance Criteria**:
- [ ] User can browse counselors and filter by specialization
- [ ] Booking confirmation appears within 2 seconds
- [ ] Push notification fires 30 minutes before session
- [ ] Video call connects within 5 seconds of joining
- [ ] Booking history shows past and upcoming sessions

---

## COMMUNITY & GAMIFICATION

Build:
- Achievement badges (visual + Firestore-backed)
- XP system (earn XP for logging moods, journaling, hitting step goals)
- Wellness streaks (consecutive days of activity)
- Daily challenges (AI-generated)
- Leaderboards (weekly, friends-only)
- Habit competitions
- Community feed (posts, likes, comments)

Badge Examples:
- 🧘 Meditation streak (7 days)
- 💧 Hydration master (8 glasses/day for 5 days)
- 🏆 Productivity champion (wellness score > 80 for 7 days)

**Acceptance Criteria**:
- [ ] XP updates in real-time on the profile screen
- [ ] Streak counter resets correctly at midnight local time
- [ ] Leaderboard loads within 3 seconds
- [ ] Badges appear with unlock animation

---

## ANALYTICS & INSIGHTS

Create advanced analytics dashboards:
- Mood trends (line chart, 7/30/90 day)
- Sleep analytics (bar chart)
- Productivity graphs (area chart)
- Wellness score history (line chart)
- Habit completion rate (percentage ring)
- Heart rate analytics (min/max/avg)
- AI-generated weekly wellness insights

Use:
- FL Chart (`fl_chart` Flutter package)

**Acceptance Criteria**:
- [ ] Charts render within 2 seconds with 90 days of data
- [ ] User can toggle between 7-day, 30-day, and 90-day views
- [ ] AI insights update weekly every Monday

---

## NOTIFICATION SYSTEM

Implement:
- Daily mood check-in reminder (configurable time)
- Habit reminders (per-habit schedule)
- Motivational quote of the day
- Counselor session reminders (30 min before)
- AI wellness tips (based on recent trends)

Use Firebase Cloud Messaging for push notifications.

**Acceptance Criteria**:
- [ ] User can customize reminder times in Settings
- [ ] Notifications respect device Do Not Disturb mode
- [ ] Tapping a notification navigates to the relevant screen

---

## FIREBASE DATABASE DESIGN

Generate complete Firestore schema for:

| Collection | Key Fields |
|---|---|
| `users` | uid, name, age, gender, goals, createdAt |
| `moods` | userId, category, intensity, notes, timestamp |
| `journals` | userId, content, sentiment, tags, timestamp |
| `wellness_scores` | userId, score, features, predictedScore, date |
| `chatbot_history` | userId, messages[], sessionId, timestamp |
| `counselor_bookings` | userId, counselorId, dateTime, status, roomId |
| `counselors` | name, bio, specializations, rating, availability |
| `achievements` | userId, badgeId, unlockedAt, xpEarned |
| `notifications` | userId, type, title, body, read, timestamp |
| `challenges` | title, description, xpReward, startDate, endDate |
| `health_metrics` | userId, steps, calories, heartRate, sleep, date |
| `activity_logs` | userId, action, metadata, timestamp |

Also generate:
- Firestore composite indexes (for common queries)
- Firebase security rules (users can only read/write their own data)

---

## APP ARCHITECTURE

Use:
- Clean Architecture
- MVVM pattern
- Repository Pattern
- Dependency Injection (via Riverpod)

Folder structure:

```text
lib/
  core/
    constants/
    theme/
    utils/
    errors/
    network/
  features/
    auth/
      data/
      domain/
      presentation/
    dashboard/
    mood/
    journal/
    chatbot/
    analytics/
    counselor/
    community/
    profile/
    settings/
  services/
    firebase/
    health/
    notifications/
    api/
  widgets/
    common/
    charts/
    cards/
    animations/
```

---

## SECURITY & PRIVACY COMPLIANCE

### Security
Implement:
- Firebase security rules (per-user data isolation)
- HTTPS-only API communication
- API key protection (environment variables, not hardcoded)
- Input validation and sanitization
- Rate limiting on FastAPI endpoints (e.g., 60 requests/min)
- Health data encryption at rest (Firestore default) and in transit (TLS)

### Privacy Compliance
Implement:
- **GDPR compliance**:
  - Explicit consent before collecting health data
  - Right to access (data export as JSON)
  - Right to erasure (full account + data deletion)
  - Data processing transparency
- **Health data regulations**:
  - No health data shared with third parties without consent
  - Health sync toggle in Settings (user can disable anytime)
  - Minimal data collection (only what's needed)
- **In-app privacy features**:
  - Privacy policy screen (accessible from Settings and onboarding)
  - Terms of service screen
  - Data deletion option (Settings → Delete My Data)
  - Consent checkboxes during onboarding

---

## PERFORMANCE OPTIMIZATION

Optimize:
- Lazy loading for lists and images
- Efficient Firestore queries (limit, pagination, indexed)
- Cached images (`cached_network_image` package)
- Riverpod state management (auto-dispose unused providers)
- Battery-efficient background sync (WorkManager / 15-min intervals)
- Minimize Firestore reads with local caching (`shared_preferences` / Hive)

---

## MODERN ANIMATIONS

Use:
- Lottie animations (`lottie` package)
- Rive animations (for interactive illustrations)
- `flutter_animate` (declarative animation chains)
- Hero transitions (screen-to-screen)
- AnimatedContainer / AnimatedSwitcher

Specific animations:
- Wellness score ring fill animation (on dashboard load)
- AI typing indicator (dot-dot-dot pulse)
- Mood emoji bounce on selection
- Card scale-up on tap
- Animated onboarding page transitions

---

## TYPOGRAPHY

Use:
- **Poppins** (headings, bold elements)
- **Inter** (body text, UI labels)

Typography should be:
- Clean
- Minimal
- Premium
- Readable (minimum 14sp body text)

---

## RESPONSIVE DESIGN

Support:
- Android phones (360dp–420dp width)
- Tablets (600dp+ width)
- Foldable devices (adaptive layouts)

Optimize for:
- Landscape mode (tablets only)
- Accessibility (semantic labels, minimum touch targets 48dp)
- Multiple screen densities (mdpi through xxxhdpi)

---

## ERROR HANDLING STRATEGY

Implement a layered error handling approach:

### Global Error Boundary
- Wrap the app in a global error handler (`FlutterError.onError` + `PlatformDispatcher.instance.onError`)
- Integrate **Firebase Crashlytics** for crash reporting

### Network Errors
- Retry logic with exponential backoff (max 3 retries)
- Offline detection with user-friendly "No connection" banner
- Graceful degradation (show cached data when offline)

### API Errors
- Typed error classes: `NetworkException`, `AuthException`, `ServerException`
- Map HTTP status codes to user-friendly messages
- Never expose raw error messages to the user

### User-Facing Feedback
- Snackbar for transient errors (network timeout)
- Dialog for blocking errors (auth expired → redirect to login)
- Empty state widgets for "no data" scenarios

---

## TESTING

Generate:
- **Unit tests**: Repository methods, ML prediction logic, sentiment scoring
- **Widget tests**: All custom widgets, form validation, navigation
- **Integration tests**: Auth flow, mood logging → Firestore, health data fetch

Target: 70%+ code coverage for core features.

---

## DEVOPS & DEPLOYMENT

Include:
- CI/CD pipeline via **GitHub Actions**
- Lint + test on every PR
- Firebase deployment (Firestore rules, Functions)
- Android APK/AAB build pipeline
- iOS build pipeline (Xcode Cloud or Codemagic)
- Environment variable setup (`.env` files, not committed to git)

---

## DOCUMENTATION REQUIRED

Generate:
- `README.md` (project overview, screenshots, setup instructions)
- Installation guide (step-by-step for new developers)
- API documentation (FastAPI auto-generated OpenAPI docs)
- Firebase setup guide (project creation, SHA keys, config files)
- ML training guide (data format, training script, deployment)
- Architecture explanation (diagrams, layer responsibilities)
- User flow diagrams (Mermaid or draw.io)

---

## ADVANCED FEATURES

Optional (v2 roadmap):
- AI voice assistant (full voice interaction)
- Meditation music player (ambient sounds)
- Breathing exercises (guided animations)
- Emergency SOS (crisis hotline quick-dial)
- Smart productivity planner (AI-scheduled to-do list)
- Burnout detection alerts
- AI-generated wellness wallpapers

---

## CODING STANDARDS

Requirements:
- Production-grade code
- Dart null safety (sound null safety)
- SOLID principles
- Reusable widgets (no code duplication)
- Clean comments (explain *why*, not *what*)
- Proper error handling (see Error Handling Strategy)
- Scalable architecture (easy to add new features)

---

## OUTPUT FORMAT & BUILD PHASES

Generate the project in phases. Dependencies between phases:

```
Phase 1 → Phase 2 → Phase 3 (sequential, foundation)
Phase 4 + Phase 5 (can run in parallel after Phase 3)
Phase 6 (depends on Phase 4 + 5)
Phase 7 (depends on all prior phases)
Phase 8 (depends on Phase 7)
```

### Phase 1 — Architecture + Setup
- Folder structure
- Firebase project setup
- Dependencies (`pubspec.yaml`)
- Theme system
- GoRouter configuration

### Phase 2 — Authentication + Onboarding
- Firebase Auth integration
- Login / Register screens
- Google Sign-In
- Onboarding flow
- User profile creation

### Phase 3 — Core UI
- Home Dashboard
- Bottom navigation
- Profile screen
- Settings screen
- Skeleton loaders and empty states

### Phase 4 — Feature Screens
- Mood Tracker
- Journal (with VADER sentiment analysis)
- AI Chatbot (OpenAI integration)
- Analytics dashboards

### Phase 5 — Health & ML
- Google Fit integration (via `health` package)
- FastAPI backend setup
- ML model training + serving
- Wellness prediction integration

### Phase 6 — Social & Booking
- Community feed + gamification
- Counselor booking + Jitsi video
- Notification system

### Phase 7 — Testing
- Unit tests
- Widget tests
- Integration tests
- Bug fixes

### Phase 8 — Deployment
- CI/CD pipeline
- Play Store build
- Firebase production deployment
- Documentation finalization

For every phase provide:
- Complete code
- File names and folder paths
- Commands to run
- Explanations and best practices
- Dependencies to install

---

## COST ESTIMATES

| Service | Free Tier | Estimated MVP Cost (monthly) |
|---|---|---|
| Firebase Auth | 10K users/month | Free |
| Cloud Firestore | 50K reads, 20K writes/day | ~$5–15 |
| Firebase Storage | 5 GB | Free |
| Firebase Functions | 2M invocations/month | Free |
| Firebase Cloud Messaging | Unlimited | Free |
| OpenAI API (GPT-4o-mini) | — | ~$10–30 (usage-dependent) |
| Jitsi Meet | Self-hosted or meet.jit.si | Free (self-hosted) |
| FastAPI Hosting (Cloud Run) | 2M requests/month | ~$5–10 |
| **Total (MVP)** | | **~$20–55/month** |

---

## FINAL EXPECTATION

The final application must look and behave like a real AI-powered startup product with:
- Premium Android UI
- Real-time health tracking
- AI-powered wellness ecosystem
- Scalable backend
- Production-ready architecture
- Beautiful animations
- High-quality user experience

Generate the complete implementation step-by-step with clean, scalable code and modern UI.
