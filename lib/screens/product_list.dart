import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Add new product",
      ),
    );
  }

  ListView? buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, position) {
          return Card(
              color: Colors.lightBlue,
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Text("p"),
                ),
                title: Text(this.products![position].name!),
                subtitle: Text(this.products![position].description!),
                onTap: () {goToDetail(this.products![position]);},
              )
          );
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productFuture = dbHelper.getProducts();
    productFuture.then((value) {
      setState(() {
        this.products = value;
        this.productCount = value.length;
        print("Number product in database:" + value.length.toString());
      });
    });
  }
  void goToDetail(Product product) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if(result!=null){
      if(result){
        getProducts();
      }
    }
  }
}
