# Involio

[Involio Mobile Application](https://github.com/insidersinc/involio_mobile)

## Getting Started
1. [Install flutter](https://docs.flutter.dev/get-started/install)
2. `git clone git@github.com:insidersinc/involio_mobile.git`
3. cd into the involio_mobile directory 
4. Create a file named `assets/env/.env` and add the text below
   ```
   IS_PRODUCTION=0
   BASE_URL=https://api.insidersapp.io/
   ```
5. Download libraries
   `flutter pub get`
6. Build generated code
   `flutter pub run build_runner build --delete-conflicting-outputs`

## Development
[Install Android Studio](https://developer.android.com/studio/)
