# asman_rider

## Initialize project

```bash
flutter pub get
flutter gen-l10n
cd packages/data-provider
dart run build_runner build
```

```bash
flutter build apk --release --split-debug-info --obfuscate
```

#TODO:

- [x] LinearProgressIndicator when changing the product quantity
- [x] pop the active ride page when completed
- [x] when login sent with it device firebase token to the server
