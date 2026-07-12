import 'dart:io';

import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
final ImagePicker _picker = ImagePicker();
File? selectedImage;
TextEditingController namecontroller = TextEditingController();
TextEditingController pricecontroller = TextEditingController();
TextEditingController detailcontroller = TextEditingController();


Future getImage() async {
  var image = await _picker.pickImage(source: ImageSource.gallery);
  if (image == null) {
    return;
  }

  selectedImage = File(image.path);
  if (!mounted) {
    return;
  }

  setState(() {});
}  

Future<void> uploadItem() async {
  if (selectedImage == null || namecontroller.text.trim().isEmpty || value == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Select an image, enter a name, and choose a category."),
      ),
    );
    return;
  }

  try {
    String addId = randomAlphaNumeric(10);
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("blogImage")
        .child(addId);

    final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
    final TaskSnapshot snapshot = await task;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    Map<String, dynamic> addProduct = {
      "Name": namecontroller.text.trim(),
      "Image": downloadUrl,
      "Price": pricecontroller.text.trim(),
      "Detail": detailcontroller.text.trim()
    };

    await DatabaseMethods().addProduct(addProduct, value!);

    if (!mounted) {
      return;
    }

    setState(() {
      selectedImage = null;
      namecontroller.clear();
      value = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.blue,
        content: Text("Product added successfully!", style: TextStyle(color: Colors.white, fontSize: 20.0)),
      ),
    );
  } on FirebaseException catch (e) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.message ?? "Firebase Storage failed. Check bucket, rules, and network."),
      ),
    );
  } catch (e) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Failed to add product: $e"),
      ),
    );
  }
}

  String? value;

  final List<String> categoryitem = [
    'Watch','Laptop','TV','Headphones'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_outlined)),
        title: Center(child: Text("Add Product", style: AppWidget.semiboldTextFieldStyle(),)),),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
          child: Container(
          margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text("Upload the product Image", style: AppWidget.LightTextFieldStyle()),
          SizedBox(height: 20.0),
          selectedImage==null? GestureDetector(
            onTap: () {
              getImage();
            },
            child: Center(
              child: Container(
                height: 150,
                width: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5), borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(Icons.add_a_photo_outlined, color: Colors.black, size: 30.0,),
            
              ),
            ),
          ): Center(
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.file(selectedImage!, fit: BoxFit.cover,)),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Product Name", 
            style: AppWidget.LightTextFieldStyle()
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: namecontroller,
              decoration: InputDecoration(border: InputBorder.none,),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Product Price", 
            style: AppWidget.LightTextFieldStyle()
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: pricecontroller,
              decoration: InputDecoration(border: InputBorder.none,),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Product Detail", 
            style: AppWidget.LightTextFieldStyle()
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              maxLines: 6,
              controller: detailcontroller,
              decoration: InputDecoration(border: InputBorder.none,),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            "Product Category", 
            style: AppWidget.LightTextFieldStyle()
          ),
          SizedBox(height: 20.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFececf8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: categoryitem.map((item) => DropdownMenuItem(value: item, child: Text(item, style: AppWidget.semiboldTextFieldStyle(),))).toList(), onChanged: ((value) => setState(() {
                  this.value = value;
                })),
                dropdownColor: Colors.white,
                hint: Text("Select Category"),
                iconSize: 36,
                icon: Icon(Icons.arrow_drop_down, color: Colors.black, ),
                value: value,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                uploadItem();
              },
              child: Text("Add Product", style: TextStyle(fontSize: 22.0)),
            ),
          )
        
        ])),
        )),
      ),
    );
  }
}