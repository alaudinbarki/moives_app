import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../home/home_screen.dart';

class HomeMasterScreen extends StatefulWidget {
  const HomeMasterScreen({super.key});

  @override
  State<HomeMasterScreen> createState() => _HomeMasterScreenState();
}

class _HomeMasterScreenState extends State<HomeMasterScreen> {
  List<Widget> pages = [
    HomeScreen(),
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        notchMargin: 6.0,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff313131),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomItem(
                  icon: Icons.dashboard, isActive: index == 0, onTap: () {}),
              BottomItem(icon: Icons.movie, isActive: index == 1, onTap: () {}),
              BottomItem(
                  icon: Icons.library_books,
                  isActive: index == 2,
                  onTap: () {}),
              BottomItem(
                  icon: Icons.more_horiz, isActive: index == 3, onTap: () {}),
            ],
          ),
        ),
      ),
      body: pages[0],
      // body: pages.elementAt(index),
    );
  }
}

class BottomItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final IconData icon;

  const BottomItem({
    super.key,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isActive ? Colors.white : AppColors.grayishPurple,
      ),
    );
  }
}
