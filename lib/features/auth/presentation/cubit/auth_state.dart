part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

///Google
final class AuthInitial extends AuthState {}

final class GoogleAuthLoading extends AuthState {}

final class GoogleAuthSuccess extends AuthState {
  final AuthResponse authResponse;
  const GoogleAuthSuccess({required this.authResponse});
}

final class GoogleAuthError extends AuthState {
  final String error;
  const GoogleAuthError(this.error);
}

///Facebook
final class FacebookAuthLoading extends AuthState {}

final class FacebookAuthSuccess extends AuthState {
  final AuthResponse authResponse;
  const FacebookAuthSuccess({required this.authResponse});
}

final class FacebookAuthError extends AuthState {
  final String error;
  const FacebookAuthError(this.error);
}

///email and password SignUp
final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final AuthResponse authResponse;
  const SignUpSuccess({required this.authResponse});
}

final class SignUpError extends AuthState {
  final String error;
  const SignUpError(this.error);
}

///email and password sign in
final class SignInLoading extends AuthState {}

final class SignInSuccess extends AuthState {
  final AuthResponse authResponse;
  const SignInSuccess({required this.authResponse});
}

final class SignInError extends AuthState {
  final String error;
  const SignInError(this.error);
}

///email and password sign in with otp
final class SignInOtpLoading extends AuthState {}

final class SignInOtpSuccess extends AuthState {}

final class SignInOtpError extends AuthState {
  final String error;
  const SignInOtpError(this.error);
}
