# MindVault AI threat model

## In scope for v1

- Lost or stolen device: app-level biometric/PIN lock and panic lock are planned; Android backups are disabled and secrets must use hardware-backed secure storage.
- Malicious apps: app-private storage and an encrypted SQLite database isolate local memories. Export archives use a password-derived key that is never stored.
- Local network attacker: desktop pairing requires a short fingerprint displayed and confirmed on both devices, followed by authenticated encrypted sessions.
- Compromised relay: per-memory AI access, minimal context packages, revocable device/session tokens, and end-to-end encryption minimize readable data.

## Deferred / residual risk

The current foundation does not yet ship database encryption, biometrics, desktop pairing, or relay E2E encryption. A rooted device, compromised OS, screenshots when protection is disabled, and content deliberately sent to Gemini remain outside the protection boundary. Production deployment must use the backend AI service; direct Gemini keys are development-only.
