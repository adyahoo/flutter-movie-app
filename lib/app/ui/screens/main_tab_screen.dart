import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/app/ui/screens/account_screen.dart';
import 'package:movie_app/app/ui/screens/home_screen.dart';
import 'package:movie_app/app/ui/screens/movies_screen.dart';
import 'package:movie_app/utils/app_color.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _curIndex = 0;

  void _onTapItem(int i) {
    setState(() {
      _curIndex = i;
    });
  }

  void _navigateSearch() {
    _onTapItem(1);
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = HomeScreen(
      onClickSearch: _navigateSearch,
    );

    switch (_curIndex) {
      case 0:
        activeScreen = HomeScreen(
          onClickSearch: _navigateSearch,
        );
        break;
      case 1:
        activeScreen = const MoviesScreen();
        break;
      case 2:
        activeScreen = const AccountScreen();
        break;
    }

    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        onTap: _onTapItem,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PrimaryColor.main,
        unselectedItemColor: TextColor.secondary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: translate("home"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie_creation_outlined),
            label: translate("movies"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.supervisor_account_rounded),
            label: translate("account"),
          ),
        ],
      ),
    );
  }
}
