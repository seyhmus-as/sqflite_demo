class Product{
  int? id;
  String? name;
  String? description;
  double? unitPrice;

  Product({required this.name,required this.description,required this.unitPrice});
  Product.withId({required this.id,required this.name,required this.description,required this.unitPrice});

  Map<String,dynamic>? toMap(){
    var map = new Map<String,dynamic>();
    map["name"]=name;
    map["description"]=description;
    map["unitPrice"]=unitPrice;
    if(id!=null){
      map["id"]=id;
    }
  }

  Product.fromObject(dynamic o){
    this.id = int.tryParse(o["id"]);
    this.name = o["name"]!;
    this.unitPrice = double.tryParse(o["unitPrice"]!);
    this.description = o["description"]!;
  }
}