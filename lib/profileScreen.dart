import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:remindmeof/loginPage.dart';
import 'package:remindmeof/models/allreminders.dart';
import 'package:remindmeof/models/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  AllReminders allReminders;
  @override
  void initState() {
    super.initState();
    user = User();
    allReminders = AllReminders();
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.yMMMd();
    return Container(
      color: Theme.of(context).accentColor,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                margin: EdgeInsets.symmetric(vertical: 10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: user.imageFile == null
                    ? Image.asset(
                        "assets/images/profile_logo.png",
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        user.imageFile,
                        fit: BoxFit.cover,
                      ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
                  Text(
                    user.fullName ?? "NA",
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    Icons.celebration,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
                  Text(
                    user.dateOfBirth == null
                        ? "NA"
                        : format.format(user.dateOfBirth),
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Icon(
                    Icons.email,
                    size: 40,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      user.email ?? "NA",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: Colors.black,
              ),
              Row(
                children: [
                  Text(
                    (allReminders.upcomingReminders.length +
                            allReminders.completedReminders.length)
                        .toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      "Total Reminder",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    (allReminders.upcomingReminders.length).toString(),
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      "Upcoming Reminder",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                thickness: 1,
                color: Colors.black,
              ),
              SizedBox(height: 20),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  BotToast.showLoading();
                  Future.delayed(Duration(seconds: 2), () {
                    BotToast.closeAllLoading();

                    BotToast.showSimpleNotification(
                      title: "Backup complete !",
                      align: Alignment.bottomCenter,
                      duration: Duration(seconds: 5),
                    );
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                    vertical: 7.5,
                    horizontal: 45,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/google-drive.png",
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Backup to Drive",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  BotToast.showLoading();
                  Future.delayed(Duration(seconds: 2), () {
                    BotToast.closeAllLoading();

                    pushNewScreen(
                      context,
                      screen: LoginPage(),
                      withNavBar: false,
                    );
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(
                    vertical: 7.5,
                    horizontal: 45,
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
