import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:remindmeof/models/user.dart';
import 'package:remindmeof/updateProfilePage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

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
                    "Create your account,",
                    style: TextStyle(fontSize: 20),
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
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: "example@gmail.com"),
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
                      controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "********",
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
                      controller: cPasswordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "********",
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
                      User user = User();

                      user.email = emailController.text;
                      user.password = passwordController.text;

                      BotToast.closeAllLoading();

                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UpdateProfilePage();
                      }));
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
                      "Sign Up",
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
