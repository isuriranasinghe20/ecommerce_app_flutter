import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Admin/home_admin.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
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
              Center(child: Text("Admin Panel", style: AppWidget.semiboldTextFieldStyle(),)),
              SizedBox(height: 20.0),
              Text("Username", style: AppWidget.semiboldTextFieldStyle(),),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Username", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.person, color: Colors.black),),
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
                  controller: userpasswordController,
                  decoration: InputDecoration(border: InputBorder.none, hintText: "Password", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.lock_outlined, color: Colors.black),),
                ),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  loginAdmin();
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
             
            ]),
          ),
        ),
    );
  }

  void loginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      for (var result in snapshot.docs) {
        if(result.data()['username'] != usernameController.text.trim()){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Your Id is not correct", style:TextStyle(color: Colors.white, fontSize: 20.0),)));
        }
        else if(result.data()['password'] != userpasswordController.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Your Password is not correct", style:TextStyle(color: Colors.white, fontSize: 20.0),)));
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeAdmin()));
        }
      }
    });
  }
}