import 'package:ecommerce_app/pages/bottomnav.dart';
import 'package:ecommerce_app/pages/login.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/services/shared_pref.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
String? name, email, password;
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();

Future<void> registration() async{
  if(password!=null && name!=null && email!=null){
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Account created successfully", style:TextStyle(color: Colors.white, fontSize: 20.0),)));
        String Id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserEmail(emailController.text);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserImage("https://firebasestorage.googleapis.com/v0/b/ecommerceapp-7e3c1.appspot.com/o/images%2Fuser.png?alt=media&token=5f8b9d4a-6f1e-4c3b-9f5e-1c2e5d6f7a8b");
        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Id": Id,
           "Image": "https://firebasestorage.googleapis.com/v0/b/ecommerceapp-7e3c1.appspot.com/o/images%2Fuser.png?alt=media&token=5f8b9d4a-6f1e-4c3b-9f5e-1c2e5d6f7a8b"
        };
        await DatabaseMethods().addUserDetails(userInfoMap, Id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));

    } on FirebaseAuthException catch (e) {
      if(e.code=='weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("The password provided is too weak.", style:TextStyle(color: Colors.white, fontSize: 20.0),)));
      }
      else if(e.code=='email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("The account already exists for that email.", style:TextStyle(color: Colors.white, fontSize: 20.0),)));
      }
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: nameController,
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  controller: emailController,
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
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: passwordController,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Enter your password", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.lock_outlined, color: Colors.black),),
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      name = nameController.text;
                      email = emailController.text;
                      password = passwordController.text;
                    });
                    // Handle sign up logic here
                  }
                  registration();
                },
                child: Center(
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
      ),
    );
  }
}