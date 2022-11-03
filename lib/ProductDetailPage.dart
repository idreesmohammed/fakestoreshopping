import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CardViewPage.dart';
import 'CartData.dart';
import 'CartDetailPage.dart';
import 'CartModel.dart';
import 'CheckOutPage.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({
    this.totalProductionDescription,
    required this.index,
  });
  final totalProductionDescription;
  int index;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with WidgetsBindingObserver {
  var productImage;
  var productDescription;
  var productCategory;
  var productId;
  var productTitle;
  var productPrice;
  var productQuantity = 0;
  var productTotalPrice;
  String _text = "";

  @override
  void initState() {
    super.initState();
    print('initState');
    _text = CartData.myCartList.length.toString();
    setState(() {});
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('didChangeAppLifecycleState: ' + state.toString());
    if (state == AppLifecycleState.resumed) {
      print('onResume');
    } else if (state == AppLifecycleState.inactive) {
      print('inActive');
    } else if (state == AppLifecycleState.paused) {
      print('onPaused');
    }
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.credit_card, color: Colors.grey),
                title: new Text(
                  'Card',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CardViewPage(
                                from: 'ProductDetailPage',
                              ))).then((value) => Navigator.pop(context));
                },
              ),
              ListTile(
                leading: new Icon(Icons.attach_money, color: Colors.grey),
                title: new Text(
                  'Cash',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckOutPage(
                                from: '',
                              ))).then((value) => Navigator.pop(context));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    productImage = widget.totalProductionDescription['image'];
    productDescription = widget.totalProductionDescription['description'];
    productCategory = widget.totalProductionDescription['category'];
    productId = widget.totalProductionDescription['id'].toString();
    productTitle = widget.totalProductionDescription['title'];
    productPrice =
        double.tryParse(widget.totalProductionDescription['price'].toString())!
            .roundToDouble();
    // productQuantity = widget.totalProductionDescription['quantity'];
    productTotalPrice = productPrice;

    bool checkIfTheItemExists() {
      for (var i = 0; i < CartData.myCartList.length; i++) {
        if ((CartData.myCartList[i].id) == (productId)) {
          return false;
        }
      }
      return true;
    }

    void addToMyCartPage() {
      if (CartData.myCartList.isEmpty) {
        CartData.myCartList.add(CartModel(
            productImage,
            productDescription,
            productCategory,
            productId,
            productTitle,
            productPrice,
            1,
            productTotalPrice));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Item added successfully")));
      } else {
        if (checkIfTheItemExists() == true) {
          CartData.myCartList.add(CartModel(
              productImage,
              productDescription,
              productCategory,
              productId,
              productTitle,
              productPrice,
              1,
              productTotalPrice));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Item added successfully")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Item already added"),
          ));
        }
      }
    }

    void addCartNumber() {
      _text = CartData.myCartList.length.toString();
      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            productTitle.toString(),
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          backgroundColor: Colors.grey,
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Stack(
                  children: <Widget>[
                    Badge(
                      position: BadgePosition.topEnd(top: 0, end: 1),
                      showBadge: CartData.myCartList.length == 0 ? false : true,
                      badgeColor: Colors.white,
                      shape: BadgeShape.circle,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: Text(
                        _text,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartDetailPage()))
                              .then((value) => addCartNumber());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height / 3,
                child: (Image.network(productImage)),
              ),
            ),
            Column(
              children: [
                Container(
                  child: Text(
                    "Price:  " +
                        (double.tryParse(productPrice.toString())!.round())
                            .toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {
                      addToMyCartPage();
                      addCartNumber();
                    },
                    child: Text(
                      "Add To Cart",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey)),
                    onPressed: () {
                      showBottomSheet();
                    },
                    child: Text(
                      'Buy Now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                child: Text(
                  productCategory,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Product Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Container(
                  child: Text(productDescription),
                ),
              ),
            ),
          ],
        ));
  }
}
