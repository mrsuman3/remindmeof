import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remindmeof/models/user.dart';
import 'package:path/path.dart' as path;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final fullnameController = TextEditingController();
  final dobController = TextEditingController();

  File _image;

  Future getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      _image = File(file.path);
      setState(() {});
    }
  }

  User user;

  @override
  void initState() {
    super.initState();
    user = User();

    _image = user.imageFile;

    fullnameController.text = user.fullName;
    dobController.text =
        "${user.dateOfBirth.year}-${user.dateOfBirth.month}-${user.dateOfBirth.day}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Edit Profile",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Edit your profile detail,",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        _image == null
                            ? Image.asset(
                                "assets/images/profile_logo.png",
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                        Positioned(
                          bottom: 5,
                          child: Text(
                            "Change",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 2.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: TextField(
                      controller: fullnameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "John Doe",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  elevation: 2.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: TextField(
                      controller: dobController,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "1997-04-15",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    BotToast.showLoading();
                    Future.delayed(Duration(seconds: 2), () async {
                      User user = User();

                      final appDir = await getApplicationDocumentsDirectory();
                      final fileName = path.basename(_image.path);
                      final savedImage =
                          await _image.copy('${appDir.path}/$fileName');

                      user.imageFile = savedImage ?? null;

                      user.fullName = fullnameController.text;

                      List<String> dobSplit = dobController.text.split("-");
                      user.dateOfBirth = DateTime(
                        int.parse(dobSplit[0]),
                        int.parse(dobSplit[1]),
                        int.parse(dobSplit[2]),
                      );

                      BotToast.closeAllLoading();

                      BotToast.showSimpleNotification(
                        title: "Profile updated !",
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
                SizedBox(height: 25),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    BotToast.showLoading();
                    Future.delayed(Duration(seconds: 2), () {
                      BotToast.closeAllLoading();

                      BotToast.showSimpleNotification(
                        title: "Email changed !",
                        align: Alignment.bottomCenter,
                        duration: Duration(seconds: 5),
                      );
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(
                      vertical: 7.5,
                      horizontal: 45,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/email.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Change Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    BotToast.showLoading();
                    Future.delayed(Duration(seconds: 2), () {
                      BotToast.closeAllLoading();

                      BotToast.showSimpleNotification(
                        title: "Password changed !",
                        align: Alignment.bottomCenter,
                        duration: Duration(seconds: 5),
                      );
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(
                      vertical: 7.5,
                      horizontal: 45,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/images/lock.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
