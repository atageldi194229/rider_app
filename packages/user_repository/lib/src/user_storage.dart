import 'package:storage/storage.dart';

/// Storage keys for the [UserStorage].
abstract class UserStorageKeys {
  /// User password
  static const appUserPassword = '__app_user_password_key__';

  /// User Phone Number
  static const appUserPhone = '__app_user_phone_key__';
}

/// {@template user_storage}
/// Storage for the UserRepository.
/// {@endtemplate}
class UserStorage {
  /// {@macro user_storage}
  const UserStorage({
    required Storage storage,
  }) : _storage = storage;

  final Storage _storage;

  /// Sets the phone number of user.
  Future<void> setAppUserPhone(String phone) => _storage.write(
        key: UserStorageKeys.appUserPhone,
        value: phone,
      );

  /// Fetches the phone number of user.
  Future<String?> fetchAppUserPhone() async {
    return _storage.read(key: UserStorageKeys.appUserPhone);
  }

  /// Sets the password of user.
  Future<void> setAppUserPassword(String password) => _storage.write(
        key: UserStorageKeys.appUserPassword,
        value: password,
      );

  /// Fetches the password of user.
  Future<String?> fetchAppUserPassword() async {
    return _storage.read(key: UserStorageKeys.appUserPassword);
  }

  /// Clear The User Storage
  Future<void> clearAppUser() {
    return _storage.clear();
  }
}
