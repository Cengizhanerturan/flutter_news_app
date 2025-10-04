abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateSuccess extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String message;
  AuthStateError(this.message);
}
