import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:remindmeof/mainPage.dart';
import 'package:remindmeof/models/user.dart';
import 'package:remindmeof/signupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                  "Sign in to,",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10),
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
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    BotToast.showLoading();
                    Future.delayed(Duration(seconds: 2), () {
                      BotToast.closeAllLoading();

                      User user = User();

                      if (user.email == emailController.text &&
                          user.password == passwordController.text) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MainPage();
                        }), (route) => false);
                      } else {
                        BotToast.showSimpleNotification(
                          title: "Email or password is incorrect!",
                          align: Alignment.bottomCenter,
                          duration: Duration(seconds: 5),
                        );
                      }
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
                      "Sign In",
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

                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MainPage();
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Sign In with Google",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Text("Don't have an account?"),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SignUpPage();
                        },
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 22,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
