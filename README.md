# rider_app

## Initialize project

- Create firebase google-serices.json file and set in the `android/app/` folder.
- Create Key Store for app and save it in root folder like `upload-keystore.jks`.
- Don't forget about key.properties file in `android/` folder. Create it also.

```bash
flutter pub get
flutter gen-l10n
cd packages/data-provider
dart run build_runner build
```

#TODO:

- [x] LinearProgressIndicator when changing the product quantity
- [x] pop the active ride page when completed
- [x] when login sent with it device firebase token to the server
