import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:remindmeof/editProfilePage.dart';
import 'package:remindmeof/homeScreen.dart';
import 'package:remindmeof/profileScreen.dart';
import 'package:remindmeof/allRemindersScreen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      AllRemindersScreen(),
      ProfileScreen(),
    ];
  }

  Color activeColor = Colors.black;
  Color inactiveColor = Colors.black54;
  Color activeColorAlternate = Colors.black;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: "Home",
        iconSize: 20,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: activeColorAlternate,
        textStyle: Theme.of(context)
            .textTheme
            .headline2
            .copyWith(color: Colors.white, fontSize: 12),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_list),
        title: "Reminders",
        iconSize: 20,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: activeColorAlternate,
        textStyle: Theme.of(context)
            .textTheme
            .headline2
            .copyWith(color: Colors.white, fontSize: 12),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person_alt),
        title: "Profile",
        iconSize: 20,
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        activeColorSecondary: activeColorAlternate,
        textStyle: Theme.of(context)
            .textTheme
            .headline2
            .copyWith(color: Colors.white, fontSize: 12),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.symmetric(vertical: 10),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/images/logo.gif",
              fit: BoxFit.fitHeight,
            ),
          ),
          title: Text(
            "Remind Me Of",
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            if (tabController.index == 2)
              GestureDetector(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: EditProfilePage(),
                    withNavBar: false,
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            SizedBox(width: 10),
          ],
        ),
        body: PersistentTabView(
          context,
          controller: tabController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          navBarStyle: NavBarStyle.style6,
          backgroundColor: Theme.of(context).primaryColor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: false,
          onItemSelected: (i) {
            setState(() {});
          },
          hideNavigationBarWhenKeyboardShows: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
        ),
      ),
    );
  }
}
