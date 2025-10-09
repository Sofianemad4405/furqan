import 'package:flutter/material.dart';
import 'package:furqan/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furqan/features/auth/presentation/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AuthScreen(onAuthComplete: (v) {});
                },
              ),
              (v) {
                return false;
              },
            );
          },
          child: Text("logout"),
        ),
      ],
    );
  }
}
