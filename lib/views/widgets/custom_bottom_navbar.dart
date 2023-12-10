import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../pages/home_page.dart';
import 'app_bar_icon.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late final PersistentTabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: AppBarIcon(icon: Icons.menu),
        ),
        actions: const [
          AppBarIcon(icon: Icons.search),
          SizedBox(width: 8),
          AppBarIcon(icon: Icons.notifications),
          SizedBox(width: 8),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.zero,
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (context) => Container(
              height: 56,
              width: 56,
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          );

          return false;
        },
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
          borderRadius: BorderRadius.circular(24),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style7,
        screens: [
          const HomePage(),
          Container(),
          Container(),
          Container(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: Colors.teal,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: Colors.teal,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: Colors.teal,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
          ),
          PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            title: 'Home',
            activeColorPrimary: Colors.teal,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: Colors.grey,
            inactiveColorSecondary: Colors.purple,
          ),
        ],
      ),
      drawer: const Drawer(
        child: Center(
          child: Column(
            children: [
              Text('Drawer'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
