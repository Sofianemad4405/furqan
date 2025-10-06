import 'package:flutter/material.dart';
import 'package:furqan/app/root_page.dart';
import 'package:furqan/features/auth/presentation/widgets/ahth_tile.dart';
import 'package:furqan/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId = 'my-web.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xFFCFECE5)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Gap(30),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A47F),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Text(
                          "F",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      "FURQAN",
                      style: TextStyle(
                        color: Color(0xFF00A47F),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Welcome back to your spiritual journey"),
                  ],
                ),
              ),
            ),
            const Gap(24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        final res = await _googleSignIn();
                        if (res.user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RootPage(),
                            ),
                          );
                        }
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    child: AhthTile(
                      tileColor: Colors.white,
                      isFacebook: false,
                      iconPath: "assets/svgs/google-svgrepo-com.svg",
                      text: "Continue with Google",
                    ),
                  ),
                  Gap(10),
                  AhthTile(
                    tileColor: Color(0xFFCFECE5),
                    isFacebook: true,
                    iconPath: "assets/svgs/facebook-svgrepo-com.svg",
                    text: "Continue with Facebook",
                  ),
                  Gap(10),
                  AhthTile(
                    tileColor: Color(0xFFD3DFDE),
                    isFacebook: false,
                    iconPath: "assets/svgs/github-svgrepo-com.svg",
                    text: "Continue with Github",
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("or")],
                  ),
                  Gap(20),
                  CustomTextField(hintText: "Email Address", isPassword: false),
                  Gap(10),
                  CustomTextField(hintText: "Password", isPassword: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
