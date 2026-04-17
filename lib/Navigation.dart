import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:brainy/screen/Home.dart';
import 'package:brainy/screen/create.dart';
import 'package:brainy/screen/profile.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key, required this.userId});
  final int userId;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final _pageController = PageController(initialPage: 0);
  final _notchController = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
    Home(userId: widget.userId),
    Create(),
    Profile(userId: widget.userId),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _notchController,
        color: Colors.white24,
        showLabel: false,
        notchColor: Colors.deepPurple,
        removeMargins: false,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_outlined, color: Colors.deepPurple),
            activeItem: Icon(Icons.home_filled, color: Colors.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.add_circle_outline,
              color: Colors.deepPurple,
            ),
            activeItem: Icon(Icons.add_circle, color: Colors.white),
            itemLabel: 'Create',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person_outline, color: Colors.deepPurple),
            activeItem: Icon(Icons.person, color: Colors.white),
            itemLabel: 'Profile',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
        kBottomRadius: 28.0,
      ),
    );
  }
}
