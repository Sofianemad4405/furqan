// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// class MainController extends GetxController {
//   var currentIndex = 0.obs; // متغير بيراقب الصفحة الحالية
// }

// class MainPage extends StatelessWidget {
//   final controller = Get.put(MainController());

//   final pages = [
//     HomePage(),
//     QuranPage(),
//     SettingsPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notti App')),
//       body: Obx(() => pages[controller.currentIndex.value]),
//       bottomNavigationBar: Obx(
//         () => BottomNavigationBar(
//           currentIndex: controller.currentIndex.value,
//           onTap: (index) => controller.currentIndex.value = index,
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Quran'),
//             BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//           ],
//         ),
//       ),
//     );
//   }
// }
