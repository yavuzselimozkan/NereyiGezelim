import 'package:flutter/material.dart';
import 'package:nereyi_gezelim_pp/bottom_navigation_bar.dart';
import 'package:nereyi_gezelim_pp/pages/home_page.dart';
import 'package:nereyi_gezelim_pp/pages/rotation_page.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int pageIndex=0;
  void onTapPage(int index)
  {
    setState(() {
      pageIndex = index;
    });
  }
  final List<Widget> pageList = [const HomePage(), const RotationPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(onTapFunc: (index) => onTapPage(index)),
      body: pageList[pageIndex],
    );
  }
}
