import 'package:ecommerce_app/pages/bottomnav.dart';
import 'package:ecommerce_app/pages/home.dart';
import 'package:ecommerce_app/pages/signup.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
String email = "";
String password = "";

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();

userLogin() async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("No user found for that email.", style: TextStyle(fontSize: 20.0))));
    } else if (e.code == 'wrong-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Wrong password provided for that user.', style: TextStyle(fontSize: 20.0))));
    }
  }
}  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.asset("images/login.png", ),
              Center(child: Text("Sign In", style: AppWidget.semiboldTextFieldStyle(),)),
              SizedBox(height: 20.0),
              Center(child: Text("Please enter the details below to \n                       continue", style: AppWidget.LightTextFieldStyle(),)),
              SizedBox(height: 40.0),
              Text("Email", style: AppWidget.semiboldTextFieldStyle(),),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Enter your email", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.email_outlined, color: Colors.black),),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
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
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Enter your password", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.lock_outlined, color: Colors.black),),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Forgot Password?", style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                    });
                    // Perform login logic here
                  }
                  userLogin();
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Don't have an account?", style: AppWidget.LightTextFieldStyle()),
                GestureDetector(
                  onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
                  child: Text("Sign Up", style: TextStyle(color: Colors.green, fontSize: 18.0, fontWeight: FontWeight.w500))),
              ])
            ]),
          ),
        ),
      ),
    );
  }
}