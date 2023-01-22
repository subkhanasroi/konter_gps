import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:konter_gps/common/icon.dart';
import 'package:konter_gps/page/about_page.dart';
import 'package:konter_gps/page/homepage.dart';
import 'package:konter_gps/widget/exit_dialog.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late List _page;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _page = [
      const Homepage(),
      const AboutPage(),
    ];
  }

  Future<bool> _onWillPop() async {
    bool exit = await openExitDialog(context) ?? false;
    if (exit) {
      setState(() {
        exit = true;
      });
    }
    return exit;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          body: _page.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: HexColor("#FEDB39"),
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(kIcLogoGps), size: 30),
                  label: "About Us"),
            ],
          )),
    );
  }
}
