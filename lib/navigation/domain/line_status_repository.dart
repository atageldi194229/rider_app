import 'package:data_provider/data_provider.dart';
import 'package:equatable/equatable.dart';

/// A base line status failure
abstract class LineStatusFailure with EquatableMixin implements Exception {
  /// Constructor
  const LineStatusFailure(this.error);

  /// The error which was caught
  final Object error;

  @override
  List<Object?> get props => [error];
}

/// Thrown when could not get the current line status
class FetchLineStatusFailure extends LineStatusFailure {
  /// Constructor
  FetchLineStatusFailure(super.error);
}

/// Thrown when could not update the current line status
class UpdateLineStatusFailure extends LineStatusFailure {
  /// Constructor
  UpdateLineStatusFailure(super.error);
}

/// LineStatus Repository
class LineStatusRepository {
  /// Constructor
  LineStatusRepository({
    required LineStatusClient lineStatusClient,
  }) : _lineStatusClient = lineStatusClient;

  final LineStatusClient _lineStatusClient;

  /// Fetch
  Future<Staff> fetchCurrentLineStatus() async {
    try {
      final response = await _lineStatusClient.getLineStatus();
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FetchLineStatusFailure(error), stackTrace);
    }
  }

  /// Update or Toggle
  Future<Staff> updateLineStatus() async {
    try {
      final response = await _lineStatusClient.updateLineStatus();
      return response.data!;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateLineStatusFailure(error), stackTrace);
    }
  }
}
