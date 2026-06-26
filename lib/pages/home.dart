import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List categories = [
  "images/headphone_icon.png",
  "images/laptop.png",
  "images/watch.png",
  "images/TV.JPG"
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        margin: EdgeInsets.only(top:30.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hey, Isuri", 
                  style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text("Good Morning",style: AppWidget.LightTextFieldStyle(),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset("images/girl.jpg", height: 70.0, width: 70.0, fit: BoxFit.cover,)),
            ],
          ),
          SizedBox(height: 30.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: MediaQuery.of(context).size.width,
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none, hintText: "Search Products", hintStyle: AppWidget.LightTextFieldStyle(), prefixIcon: Icon(Icons.search, color: Colors.black),),
            ),),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Categories", 
                  style: AppWidget.semiboldTextFieldStyle()
                ),
                Text(
                  "see all", 
                  style: TextStyle(color: Color(0xFFfd6f3e), fontSize: 18.0, fontWeight: FontWeight.bold)
                ),
                
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  height: 130,
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.only(right: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFfd6f3e),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text("All", 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold), 
                  ))
                ),

                Expanded(
                  child: Container(
                    height: 130,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return CategoryTile(image: categories[index]);
                      }
                    ),
                    // Add your onboarding content here 
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
} 

class CategoryTile extends StatelessWidget {
  String image;
  CategoryTile({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 90,
      width: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Image.asset(image, height: 50, width: 50, fit: BoxFit.cover,),
        Icon(Icons.arrow_forward)
      ],
      ),
    );

  }
}
