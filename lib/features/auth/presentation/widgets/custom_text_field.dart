import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.icon,
    this.isPasswordShown = false,
    this.onPressed,
  });

  final String hintText;
  final bool isPassword;
  final Icon icon;
  final bool isPasswordShown;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword && !isPasswordShown,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onPressed,
                icon: isPasswordShown
                    ? const Icon(Iconsax.eye_slash)
                    : const Icon(Iconsax.eye),
              )
            : null,
        prefixIcon: icon,
        border: OutlineInputBorder(
          // borderSide: const BorderSide(width: 3, color: Color(0xFF009384)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: Color(0xFF009384)),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: .5, color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }
}
