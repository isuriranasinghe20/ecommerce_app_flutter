import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.asset("images/login.png", ),
            Center(child: Text("Sign Up", style: AppWidget.semiboldTextFieldStyle(),)),
            SizedBox(height: 20.0),
            Center(child: Text("Please enter the details below to \n                       continue", style: AppWidget.LightTextFieldStyle(),)),
             SizedBox(height: 40.0),
            Text("Name", style: AppWidget.semiboldTextFieldStyle(),),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none, hintText: "Enter your name", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.person, color: Colors.black),),
              ),
            ),
            SizedBox(height: 20.0),
            Text("Email", style: AppWidget.semiboldTextFieldStyle(),),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none, hintText: "Enter your email", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.email_outlined, color: Colors.black),),
              ),
            ),
            SizedBox(height: 20.0),
            Text("Password", style: AppWidget.semiboldTextFieldStyle(),),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none, hintText: "Enter your password", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.lock_outlined, color: Colors.black),),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(child: Text("SIGN UP", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),)),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Already have an account?", style: AppWidget.LightTextFieldStyle()),
              GestureDetector(
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn())),
                child: Text("Login", style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.w500))),
            ])
          ]),
        ),
      ),
    );
  }
}