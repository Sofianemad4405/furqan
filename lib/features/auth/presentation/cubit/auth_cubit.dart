import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final supabase = sl<SupabaseClient>();

  Future<void> googleSignIn() async {
    try {
      emit(GoogleAuthLoading());

      const webClientId =
          '885310355539-7vksih53bkloogp9mb3ra6vst8jjnsah.apps.googleusercontent.com';

      final googleSignIn = GoogleSignIn(serverClientId: webClientId);
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(const GoogleAuthError("Sign in cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        emit(const GoogleAuthError("Missing token"));
        return;
      }

      final authResponse = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      emit(GoogleAuthSuccess(authResponse: authResponse));
    } catch (e) {
      emit(GoogleAuthError(e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: kIsWeb ? null : 'io.supabase.flutter://callback',
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
  }

  Future<void> signInWithGithub() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.github,
      redirectTo: kIsWeb
          ? null
          : 'my.scheme://my-host', // Optionally set the redirect link to bring back the user via deeplink.
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode
                .externalApplication, // Launch the auth screen in a new webview on mobile.
    );
  }

  Future<void> signUpNewUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(SignUpLoading());
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
        emailRedirectTo: "io.supabase.flutter://login-callback",
      );
      log(res.user.toString());
      emit(SignUpSuccess(authResponse: res));
    } on AuthApiException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(SignInLoading());
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      log(res.user.toString());
      emit(SignInSuccess(authResponse: res));
    } on AuthApiException catch (e) {
      log(e.toString());
      emit(SignInError(e.message));
    }
  }

  Future<void> signInWithEmailOtp({
    required String email,
    required BuildContext context,
  }) async {
    try {
      emit(SignInOtpLoading());
      await supabase.auth.signInWithOtp(email: email);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("OTP sent!")));
      emit(SignInOtpSuccess());
    } on Exception catch (e) {
      emit(SignInOtpError(e.toString()));
    }
  }

  // Future<void> verifyOtp(String email, String otp) async {
  //   try {
  //     await supabase.auth.verifyOTP(
  //       email: email,
  //       token: otp,
  //       type: OtpType.email,
  //     );
  //     emit(SignInSuccess(authResponse: AuthResponse()));
  //   } on Exception catch (e) {
  //     emit(SignInError(e.toString()));
  //   }
  // }

  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.flutter://reset-password',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset link sent to your email!'),
          backgroundColor: Colors.green,
        ),
      );
    } on AuthApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }
}
