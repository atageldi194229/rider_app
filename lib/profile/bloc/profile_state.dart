// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  populated,
  failure,
}

class ProfileState extends Equatable {
  const ProfileState({
    required this.status,
    this.riderState,
  });

  const ProfileState.initial() : this(status: ProfileStatus.initial);

  final ProfileStatus status;
  final RiderState? riderState;

  @override
  List<Object?> get props => [status, riderState];

  ProfileState copyWith({
    ProfileStatus? status,
    RiderState? riderState,
  }) {
    return ProfileState(
      status: status ?? this.status,
      riderState: riderState ?? this.riderState,
    );
  }
}
