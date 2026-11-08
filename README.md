# J’Donuts

A warm, mobile-first donut shop app featuring phone/OTP sign-in, a browsable
catalog, product details, shop locations, and animated loyalty rewards.

## Run locally

```sh
flutter pub get
flutter run
```

Sign-in is a UAT flow: enter a phone number and any four-digit code. OTP
verification expires after five minutes. Catalog, cart count, and rewards use
local sample data; no real authentication or checkout is performed.

## Project structure

- `lib/core/`: design system, assets, Freezed catalog models, and Riverpod state
- `lib/features/auth/`: phone sign-in and OTP
- `lib/features/home/`: catalog, shops, and app navigation
- `lib/features/product/`: product details and cart actions
- `lib/features/rewards/`: membership points and vouchers
