class Product{
  int? id;
  String name;
  String description;
  double unitPrice;

  Product({required this.name,required this.description,required this.unitPrice});
  Product.withId({required this.id,required this.name,required this.description,required this.unitPrice});
}