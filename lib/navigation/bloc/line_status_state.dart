part of 'line_status_bloc.dart';

enum LineStatus {
  /// At the start only
  initial,

  /// When  fetching status
  loading,

  /// When thrown exception
  failure,

  /// When status is 1
  online,

  /// When status is 0
  offline,
}
