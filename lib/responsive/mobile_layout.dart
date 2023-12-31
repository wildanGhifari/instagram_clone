import 'package:flutter/material.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/providers/users_provider.dart';
import 'package:instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int currentPage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void _navigationSelected(int index) {
    setState(() {
      pageController.jumpToPage(index);
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: mobileHomeScreenItems,
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: _navigationSelected,
        selectedIndex: currentPage,
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.add_circle_rounded),
            icon: Icon(Icons.add_circle_outline),
            label: "Add Post",
          ),
          const NavigationDestination(
            selectedIcon: Icon(Icons.video_collection_rounded),
            icon: Icon(Icons.video_collection_outlined),
            label: "Videos",
          ),
          NavigationDestination(
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
