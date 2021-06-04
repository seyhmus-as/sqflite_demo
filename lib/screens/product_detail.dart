import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductDetail extends StatefulWidget{
  Product product;
  ProductDetail (this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options{delete,update}

class _ProductDetailState extends State{
  Product? product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail : ${product!.name}"),
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (context)=><PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value : Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value : Options.update,
                child: Text("Update"),
              )
            ],
          )
        ],
      ),

    );
  }

  void selectProcess(Options options) async{
    switch(options){
      case Options.delete:
        await dbHelper.delete(product!.id!);
        Navigator.pop(context,true);
        break;
      default:
    }
  }
}