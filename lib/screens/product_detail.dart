import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { delete, update }

class _ProductDetailState extends State {
  Product? product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice= TextEditingController();

  @override
  void initState() {
    txtName.text = product!.name!;
    txtDescription.text = product!.description!;
    txtUnitPrice.text = product!.unitPrice!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail : ${product!.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update"),
              )
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product!.id!);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(Product.withId(id: product!.id, name: txtName.text, description: txtDescription.text, unitPrice: int.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescription(),
          buildUnitPriceField(),
        ],
      ),
    );
  }
  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Name"),
      controller: txtName,
    );
  }

  buildDescription() {
    return TextField(
      decoration: InputDecoration(labelText: "Description"),
      controller: txtDescription,
    );
  }

  buildUnitPriceField(){
    return TextField(
      decoration: InputDecoration(labelText: "Unit Price"),
      controller: txtUnitPrice,
    );
  }
}
