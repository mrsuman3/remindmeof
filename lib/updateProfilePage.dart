import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remindmeof/loginPage.dart';
import 'package:remindmeof/models/user.dart';
import 'package:path/path.dart' as path;

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
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
                  child: Image.asset(
                    "assets/images/logo.gif",
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  '" Remind Me Of "',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(0, 2),
                          blurRadius: 5,
                        ),
                      ]),
                ),
                SizedBox(height: 35),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Update your profile detail,",
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

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }), (route) => false);
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
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
