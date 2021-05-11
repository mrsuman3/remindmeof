import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remindmeof/models/allcategories.dart';
import 'package:remindmeof/models/allreminders.dart';
import 'package:remindmeof/models/category.dart';
import 'package:remindmeof/models/reminder.dart';

class EditReminderPage extends StatefulWidget {
  final Reminder reminder;

  const EditReminderPage({@required this.reminder});

  @override
  _EditReminderPageState createState() => _EditReminderPageState();
}

class _EditReminderPageState extends State<EditReminderPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final timeController = TextEditingController();
  final timeToNotifyController = TextEditingController();

  Category category;
  Category initialCategory;
  String repeatAfter;

  List<String> repeatString = ["Never", "Daily", "Weekly", "Monthly"];

  AllCategories allCategories;

  DateTime reminderTime;
  DateTime reminderNotifyTime;

  reminderDatePicker() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 20)),
    );

    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 00),
    );

    reminderTime = date.add(Duration(hours: time.hour, minutes: time.minute));

    var format = DateFormat.jm().add_yMMMMEEEEd();

    timeController.text = format.format(reminderTime);
    setState(() {});
  }

  notifyDatePicker() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 20)),
    );

    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 00, minute: 00),
    );

    reminderNotifyTime =
        date.add(Duration(hours: time.hour, minutes: time.minute));

    var format = DateFormat.jm().add_yMMMMEEEEd();

    timeToNotifyController.text = format.format(reminderNotifyTime);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    allCategories = AllCategories();
    titleController.text = widget.reminder.title;
    descController.text = widget.reminder.description;
    var format = DateFormat.jm().add_yMMMMEEEEd();
    reminderTime = widget.reminder.dateTime;
    reminderNotifyTime = widget.reminder.timeToBeNotified;
    timeController.text = format.format(widget.reminder.dateTime);
    timeToNotifyController.text =
        format.format(widget.reminder.timeToBeNotified);

    initialCategory = widget.reminder.category;

    if (widget.reminder.repeatAfter != null) {
      if (widget.reminder.repeatAfter.inDays == 1) {
        repeatAfter = "Daily";
      } else if (widget.reminder.repeatAfter.inDays == 7) {
        repeatAfter = "Weekly";
      } else if (widget.reminder.repeatAfter.inDays == 30) {
        repeatAfter = "Monthly";
      } else {
        repeatAfter = "Never";
      }
    } else {
      repeatAfter = "Never";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Edit Reminder",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: descController,
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  reminderDatePicker();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        enabled: false,
                        controller: timeController,
                        decoration: InputDecoration(
                          labelText: "Time",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  notifyDatePicker();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.5),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        controller: timeToNotifyController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Time to be notified",
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 16),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                          value: category,
                          hint: Text(initialCategory.title),
                          onChanged: (x) {
                            category = x;
                            setState(() {});
                          },
                          items: List<DropdownMenuItem>.generate(
                            allCategories.categories.length,
                            (i) => DropdownMenuItem(
                              child: Text(allCategories.categories[i].title),
                              value: allCategories.categories[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repeat After",
                      style: TextStyle(fontSize: 16),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton(
                          value: repeatAfter,
                          hint: Text("Select"),
                          onChanged: (x) {
                            repeatAfter = x;
                            setState(() {});
                          },
                          items: List<DropdownMenuItem>.generate(
                            repeatString.length,
                            (i) => DropdownMenuItem(
                              child: Text(repeatString[i]),
                              value: repeatString[i],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  BotToast.showLoading();
                  Future.delayed(Duration(seconds: 2), () {
                    BotToast.closeAllLoading();
                    Duration duration;

                    if (repeatAfter == "Daily") {
                      duration = Duration(days: 1);
                    } else if (repeatAfter == "Weekly") {
                      duration = Duration(days: 7);
                    } else if (repeatAfter == "Monthly") {
                      duration = Duration(days: 30);
                    }

                    AllReminders allReminders = AllReminders();

                    allReminders.upcomingReminders.removeWhere(
                        (element) => element.id == widget.reminder.id);

                    allReminders.completedReminders.removeWhere(
                        (element) => element.id == widget.reminder.id);

                    allReminders.upcomingReminders.insert(
                      0,
                      Reminder(
                        id: allReminders.upcomingReminders.length + 1,
                        title: titleController.text,
                        description: descController.text,
                        category: category ?? widget.reminder.category,
                        dateTime: reminderTime,
                        timeToBeNotified: reminderNotifyTime,
                        repeatAfter: duration,
                      ),
                    );

                    BotToast.showSimpleNotification(
                      title: "Reminder Updated!",
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
                  child: Text(
                    "Update",
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
