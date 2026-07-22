# MindVault AI

Private, local-first AI memory workspace for Android. This repository currently implements the production-ready foundation requested in Phase 1 and the initial capture slice of Phase 2.
### Fest off all ugly ui i need to fix that 
## Run

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Without configuration the app uses `MockAIService` and makes no AI network calls. Development-only direct Gemini mode is selected with `--dart-define=GEMINI_API_KEY=...`. Production should use `--dart-define=GEMINI_BACKEND_URL=https://...`; never put keys in source, assets, manifests, or release builds.

Build with `flutter build apk --debug`. For release signing, create a private upload keystore outside Git, configure an untracked `android/key.properties`, add its signing config to `android/app/build.gradle.kts`, then run `flutter build apk --release`.

Android system backup is deliberately disabled because MindVault will provide a user-controlled encrypted archive workflow. See [THREAT_MODEL.md](THREAT_MODEL.md) for security boundaries and deferred controls.
