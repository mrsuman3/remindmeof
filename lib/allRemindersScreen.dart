import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:remindmeof/editReminderPage.dart';
import 'package:remindmeof/models/allreminders.dart';
import 'package:remindmeof/models/reminder.dart';
import 'package:remindmeof/widgets/reminderWIdget.dart';

class AllRemindersScreen extends StatefulWidget {
  @override
  _AllRemindersScreenState createState() => _AllRemindersScreenState();
}

class _AllRemindersScreenState extends State<AllRemindersScreen> {
  List<Reminder> allRemindersObject;

  AllReminders allReminders;

  @override
  void initState() {
    super.initState();

    allReminders = AllReminders();
    allRemindersObject =
        allReminders.upcomingReminders + allReminders.completedReminders;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              allRemindersObject.length == 0
                  ? Center(
                      child: Text("No Reminders!"),
                    )
                  : Column(
                      children: List<Widget>.generate(
                        allRemindersObject.length,
                        (i) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            pushNewScreen(
                              context,
                              withNavBar: false,
                              screen: EditReminderPage(
                                  reminder: allRemindersObject[i]),
                            ).then((value) {
                              allReminders = AllReminders();
                              allRemindersObject =
                                  allReminders.upcomingReminders +
                                      allReminders.completedReminders;
                              setState(() {});
                            });
                          },
                          child:
                              ReminderWidget(reminder: allRemindersObject[i]),
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
