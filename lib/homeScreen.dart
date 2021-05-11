import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:remindmeof/createReminderPage.dart';
import 'package:remindmeof/models/allreminders.dart';
import 'package:remindmeof/models/reminder.dart';
import 'package:remindmeof/models/user.dart';
import 'package:remindmeof/widgets/reminderWIdget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Reminder> upcomingReminders = [];
  List<Reminder> completedReminders = [];
  User user;
  AllReminders allReminders;

  @override
  void initState() {
    super.initState();

    user = User();
    allReminders = AllReminders();
    upcomingReminders = allReminders.upcomingReminders;
    completedReminders = allReminders.completedReminders;
  }

  @override
  Widget build(BuildContext context) {
    String userName;
    if (user.fullName != null) {
      userName = user.fullName;
    } else {
      userName = ",";
    }

    return Container(
      color: Theme.of(context).accentColor,
      alignment: Alignment.center,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Hello " + userName,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  if (upcomingReminders.length != 0)
                    Text(
                      "You have ${upcomingReminders.length} upcoming reminders,",
                      style: TextStyle(fontSize: 18),
                    ),
                  SizedBox(height: 5),
                  Column(
                    children: List<Widget>.generate(
                      upcomingReminders.length,
                      (i) => ReminderWidget(
                        reminder: upcomingReminders[i],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (completedReminders.length != 0)
                    Text(
                      "You have ${completedReminders.length} completed reminders,",
                      style: TextStyle(fontSize: 18),
                    ),
                  SizedBox(height: 5),
                  Column(
                    children: List<Widget>.generate(
                      completedReminders.length,
                      (i) => ReminderWidget(
                        reminder: completedReminders[i],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                pushNewScreen(
                  context,
                  screen: CreateReminderPage(),
                  withNavBar: false,
                ).then((value) {
                  setState(() {});
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
