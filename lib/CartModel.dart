class CartModel {
  String image;
  String description;
  String category;
  String id;
  String title;
  var price;
  var quantity;
  double totalPrice;

  CartModel(this.image, this.description, this.category, this.id, this.title,
      this.price, this.quantity, this.totalPrice);
}
