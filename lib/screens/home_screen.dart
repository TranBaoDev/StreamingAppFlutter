import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/screens/pages/newFeed_screen.dart';
import 'package:flutter_streaming_app/screens/pages/live_screen.dart';
import 'package:flutter_streaming_app/screens/pages/profile_screen.dart';
import 'package:flutter_streaming_app/utils/colors.dart';
import 'package:flutter_streaming_app/utils/icons.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  onTabChange(int currentTab) {
    setState(() {
      _currentTab = currentTab;
    });
  }

  final List<Widget> _screens = [
    const NewfeedScreen(),
    const LiveScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // appBar: AppBar(
      //   title: const Text('Main UI'),
      //   actions: [
      //     PopupMenuButton<MenuAction>(
      //       onSelected: (value) async {
      //         switch (value) {
      //           case MenuAction.logout:
      //             await FirebaseAuth.instance.signOut();
      //             if (!mounted) return;
      //             Navigator.of(context).pushNamedAndRemoveUntil(
      //               onBoardingRoute,
      //               (_) => false,
      //             );
      //         }
      //       },
      //       itemBuilder: (context) {
      //         return [
      //           const PopupMenuItem<MenuAction>(
      //             value: MenuAction.logout,
      //             child: Text('Logout'),
      //           )
      //         ];
      //       },
      //     ),
      //   ],
      // ),
      body: _screens[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: filledColor,
        unselectedItemColor: outlineColor,
        currentIndex: _currentTab,
        elevation: 0,
        onTap: onTabChange,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: _currentTab == 0 ? homeBold : homeOutlined,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: _currentTab == 1 ? addBtnBold : addBtnOutlined,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: _currentTab == 2 ? profileBold : profileOutlined,
          ),
        ],
      ),
    );
  }
}
