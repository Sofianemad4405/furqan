import 'package:flutter/material.dart';
import 'package:furqan/core/themes/cubit/theme_cubit.dart';

PreferredSizeWidget buildAppBar(ThemeCubit themeProvider) {
  return AppBar(
    title: Row(
      children: [
        // Arabic Logo
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: []),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text(
              'ق',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text('Al-Quran Kareem'),
      ],
    ),
    actions: [
      // Theme Toggle
      IconButton(
        onPressed: () => themeProvider.toggleTheme(),
        icon: Icon(
          themeProvider.isDarkMood() ? Icons.dark_mode : Icons.light_mode,
        ),
        tooltip: themeProvider.isDarkMood() ? 'Dark Mode' : 'Light Mode',
      ),

      // Language Toggle
      PopupMenuButton<String>(
        // onSelected: (String languageCode) {
        //   themeProvider.setLanguage(languageCode);
        // },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 'en',
            child: Row(
              children: [Text('🇺🇸'), SizedBox(width: 8), Text('English')],
            ),
          ),
          const PopupMenuItem(
            value: 'ar',
            child: Row(
              children: [Text('🇸🇦'), SizedBox(width: 8), Text('العربية')],
            ),
          ),
          const PopupMenuItem(
            value: 'ur',
            child: Row(
              children: [Text('🇵🇰'), SizedBox(width: 8), Text('اردو')],
            ),
          ),
          const PopupMenuItem(
            value: 'bn',
            child: Row(
              children: [Text('🇧🇩'), SizedBox(width: 8), Text('বাংলা')],
            ),
          ),
          const PopupMenuItem(
            value: 'uz',
            child: Row(
              children: [Text('🇺🇿'), SizedBox(width: 8), Text('O\'zbek')],
            ),
          ),
        ],
        child: const Icon(Icons.language),
      ),
    ],
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
