import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/browse/view/browse_screen.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/home/view/home_tab.dart';
import 'package:movies_app/features/main_layout/ui/screens/lay_out/search/view/search_tab.dart';
import '../../../../../core/constants/app_colors.dart';

class LayOut extends StatefulWidget {
  static const String routeName = "layOut";

  LayOut({super.key});

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  int currentIndex = 0;

  List<Widget> tabs = [HomeTab(),SearchTab(),BrowseScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.bottomNav,
          borderRadius: BorderRadius.circular(8)),
      child: BottomNavigationBar(
        iconSize: 25,
        items: const [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(
                  FontAwesomeIcons.house,
                ),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Icon(FontAwesomeIcons.searchengin),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Icon(FontAwesomeIcons.compass),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Icon(FontAwesomeIcons.user),
              ),
              label: ""),
        ],
        onTap: _onItemClick,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.iconYellow, // Selected icon color
        unselectedItemColor: AppColors.iconWhite, // Unselected icon color
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
    );
  }

  void _onItemClick(int index) {
    currentIndex = index;
    setState(() {});
  }
}
