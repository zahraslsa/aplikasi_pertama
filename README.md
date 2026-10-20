# CODIFY

CODIFY is an offline Flutter learning app for Grade X Software and Game
Development (PPLG) students. It introduces programming fundamentals through
diagnostic assessment, guided material, and interactive practice.

## Features

- A 25-question diagnostic test with scores for five competencies.
- Adaptive recommendations that open the related learning material.
- Twelve material detail pages with examples and summaries.
- Two interactive multiple-choice questions for each material, with answer
  checking, explanations, scores, and adaptive feedback.
- Local progress, diagnostic and practice history, completed materials, and
  learner profile.
- Material completion can be recorded from a material page or automatically
  after a practice score of at least 80.

## Offline data

The app uses `shared_preferences` for on-device storage. It does not require
Firebase or an internet connection for learning, saving results, or viewing
progress. Passwords are not stored by the profile feature.

## Run and validate

```bash
flutter pub get
flutter run
flutter analyze
flutter test
```
