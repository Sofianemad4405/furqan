import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.isPassword,
  });

  final String hintText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Iconsax.eye) : null,
        prefixIcon: Icon(!isPassword ? Iconsax.sms : Iconsax.lock),
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
