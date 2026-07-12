import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/pages/product_detail.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:ecommerce_app/widget/support_widget.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream? CategoryStream;

  getontheload() async {
    CategoryStream = await DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProducts() {
    return StreamBuilder(
      stream: CategoryStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Image.network(
                      ds["Image"],
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10.0),
                    Text(ds["Name"], style: AppWidget.semiboldTextFieldStyle()),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "\$${ds["Price"]}",
                            style: const TextStyle(
                              color: Color(0xFFfd6f3e),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(
                              image: ds["Image"],
                              name: ds["Name"],
                              price: ds["Price"],
                              detail: ds["Detail"]
                            )));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFfd6f3e),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(backgroundColor: Color(0xfff2f2f2)),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: [Expanded(child: allProducts())]),
      ),
    );
  }
}
