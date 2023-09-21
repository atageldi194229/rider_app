import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:user_repository/user_repository.dart';

/// {@template authentication_exception}
/// Exceptions from the authentication client.
/// {@endtemplate}
abstract class UserException implements Exception {
  /// {@macro authentication_exception}
  const UserException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template log_in_failure}
/// Thrown during the sign in a process occurs failure.
/// {@endtemplate}
class LogInFailure extends UserException {
  /// {@macro log_in_failure}
  const LogInFailure(super.error);
}

/// {@template log_in_cancelled}
/// Thrown during  before the sign in a process started.
/// {@endtemplate}
class LogInCancelled extends UserException {
  /// {@macro log_in_cancelled}
  const LogInCancelled(super.error);
}

/// {@template log_out_failure}
/// Thrown during the sign in a process occurs failure.
/// {@endtemplate}
class LogOutFailure extends UserException {
  /// {@macro log_out_failure}
  const LogOutFailure(super.error);
}

/// {@template get_state_failure}
/// Thrown during the get state failure.
/// {@endtemplate}
class GetStateFailure extends UserException {
  /// {@macro get_state_failure}
  const GetStateFailure(super.error);
}

/// Repository which manages the user domain.
class UserRepository {
  /// {@macro user_repository}
  UserRepository({
    required AuthenticationClient authenticationClient,
    required ProfileClient profileClient,
    required UserStorage storage,
  })  : _authenticationClient = authenticationClient,
        _profileClient = profileClient,
        _storage = storage;

  final AuthenticationClient _authenticationClient;
  final ProfileClient _profileClient;
  final StreamController<User> _userStream = StreamController();
  final UserStorage _storage;

  /// Stream of [User] which will emit the current user
  Stream<User> get user => _userStream.stream;

  /// Tries to login the user
  /// using the saved credentials
  /// // If failure anonymous user is streamed
  Future<void> logInWithSavedCredentials() async {
    try {
      final phone = await _storage.fetchAppUserPhone();
      final password = await _storage.fetchAppUserPassword();

      if (phone != null && password != null) {
        await logIn(
          phone: phone,
          password: password,
        );
      } else {
        throw LogInCancelled(Exception());
      }
    } on LogInCancelled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInFailure(error), stackTrace);
    }
  }

  /// Starts the Sign In with phone and password
  ///
  /// Throws a [LogInFailure] if an exception occurs
  Future<AuthResponse> logIn({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _authenticationClient.logIn(phone, password);
      final staff = response.data?.staff;

      if (staff != null) {
        _userStream.add(
          User(
            id: staff.id!,
            phone: staff.phone,
          ),
        );

        await _storage.setAppUserPhone(phone);
        await _storage.setAppUserPassword(password);
      }
      return response;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInFailure(error), stackTrace);
    }
  }

  /// Starts the Sign Out
  ///
  /// Throws a [LogOutFailure] if an exception occurs
  Future<void> logOut() async {
    try {
      await _authenticationClient.logOut();
      _userStream.add(User.anonymous);
      await _storage.clearAppUser();
    } catch (error, stackTrace) {
      _userStream.add(User.anonymous);
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  /// Gets the current state of rider
  ///
  /// Throws a [GetStateFailure] if an exception occurs
  Future<RiderState> getState() async {
    try {
      final response = await _profileClient.getState();
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(GetStateFailure(error), stackTrace);
    }
  }
}
