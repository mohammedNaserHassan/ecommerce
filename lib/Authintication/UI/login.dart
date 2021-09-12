import 'dart:io';

import 'package:ecommerce/Animation/FadeAnimation.dart';
import 'package:ecommerce/Authintication/UI/register.dart';
import 'package:ecommerce/Authintication/UI/resetPassword.dart';
import 'package:ecommerce/MyWidgets/CustomButton.dart';
import 'package:ecommerce/MyWidgets/Custom_textfield.dart';
import 'package:ecommerce/Provider/AuthProvider.dart';
import 'package:ecommerce/Provider/MyProvider.dart';
import 'package:ecommerce/Services/Router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static final routeName = 'LoginnPage';

  Login();

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context,provider,c)=>Stack(
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(

                  image: DecorationImage(
                    image: AssetImage("Assets/Images/profile.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: null /* add child content here */,
              ),
            ),
            Positioned(
                top: 50,
                child: IconButton(
                  onPressed: () {
                    exit(0);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      text(40, 'Welcome Back!'),
                      SizedBox(
                        height: 20,
                      ),
                      text(28, 'Sign in to your account'),
                      SizedBox(
                        height: 80,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.black54),
                        child: Custom_textfield(
                          label: 'Email',
                          textEditingController:
                          provider.emailController,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.black54),
                        child: Custom_textfield(
                          label: 'Password',
                          textEditingController:
                          provider.passwordController,
                          obscure: true,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child:  GestureDetector(
                            onTap: () {
                              AppRouter.appRouter.gotoPagewithReplacment(
                                  ResetPassword.routeName);
                            },
                            child: FadeAnimation(
                                1.5,
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                        Colors.white,
                                        fontWeight: FontWeight.w100
                                    ),
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        elevation: 0,
                        minWidth: double.maxFinite,
                        color: Colors.red[700],
                        onPressed: () {
                          provider.login();
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: text(20, 'LOGIN')),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            text(18, 'Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  AppRouter.appRouter.gotoPagewithReplacment(
                                      Register.routeName);
                                },
                                child: text(18, 'Sign Up'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text(double size, String text) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: size),
    );
  }
}
