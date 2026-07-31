import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _currenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currenIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currenIndex == 0
                ? Image.asset(
                    "assets/images/home_filled.png",
                    color: Colors.white,
                  )
                : Image.asset(
                    "assets/images/home_unfilled.png",
                    color: Colors.grey,
                  ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/library.png",
              color: _currenIndex == 1 ? Colors.white : Colors.grey,
            ),
            label: "Library",
          ),
        ],
      ),
    );
  }
}
