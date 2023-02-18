import 'package:flutter/material.dart';
import 'package:share_post/const/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_post/views/screens/chats/all_user_screen.dart';
import 'package:share_post/views/screens/info_screen.dart';
import 'package:share_post/views/screens/posts/posts_screen.dart';
import 'package:share_post/views/screens/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  List pages = [
    PostsScreen(),
    AllUsersScreen(),
    const InfoScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: pages[index],
      bottomNavigationBar: Container(
        width: width,
        height: 70,
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MenuItem(
              icon: Iconsax.home,
              isActive: index == 0 ? true : false,
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            MenuItem(
              icon: Iconsax.message,
              isActive: index == 1 ? true : false,
              onTap: () {
                setState(() {
                  index = 1;
                });
              },
            ),
            MenuItem(
              icon: Iconsax.note_14,
              isActive: index == 2 ? true : false,
              onTap: () {
                setState(() {
                  index = 2;
                });
              },
            ),
            MenuItem(
              icon: Iconsax.user,
              isActive: index == 3 ? true : false,
              onTap: () {
                setState(() {
                  index = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.isActive,
    this.onTap,
    required this.icon,
  }) : super(key: key);
  final bool isActive;
  final Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 18,
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondary : AppColors.white,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.secondary.withOpacity(0.2)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              icon,
              color: isActive ? AppColors.secondary : AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
