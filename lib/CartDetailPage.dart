import 'package:flutter/material.dart';
import 'CardViewPage.dart';
import 'CartData.dart';
import 'CheckOutPage.dart';

class CartDetailPage extends StatefulWidget {
  @override
  _CartDetailPageState createState() => _CartDetailPageState();
}

class _CartDetailPageState extends State<CartDetailPage> {
  Widget listItem(BuildContext context, int index) {
    String productImage = CartData.myCartList[index].image;
    String productTitle = CartData.myCartList[index].title;
    int productQuantity = CartData.myCartList[index].quantity;
    return Container(
        height: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: EdgeInsets.all(2),
        child: Row(children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 100,
              height: 100,
              child: Image.network(
                productImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                        productTitle.toString(),
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      )),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (CartData.myCartList[index].quantity > 1) {
                                  CartData.myCartList[index].totalPrice =
                                      CartData.myCartList[index].price *
                                          (CartData.myCartList[index].quantity -
                                              1);
                                  CartData.myCartList[index].quantity--;
                                } else {
                                  CartData.myCartList.removeAt(index);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Item removed successfully"),
                                  ));
                                }
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            productQuantity.toString(),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (CartData.myCartList[index].quantity <=
                                      4) {
                                    CartData.myCartList[index].quantity++;
                                    CartData.myCartList[index].totalPrice =
                                        CartData.myCartList[index].quantity *
                                            CartData.myCartList[index].price;
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'You have reached the max number of quantities'),
                                    ));
                                  }
                                });
                              },
                              icon: Icon(Icons.add),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Item deleted successfully"),
                        ));
                        setState(() {
                          CartData.myCartList.removeAt(index);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                'Price: ' +
                                    double.parse(CartData
                                            .myCartList[index].totalPrice
                                            .toString())
                                        .round()
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            margin: EdgeInsets.only(bottom: 20, right: 20),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.grey,
                              onPressed: () {
                                CartData.myCartList.removeAt(index);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Item removed successfully"),
                                ));
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          )
        ]));
  }

  static double addTotalAmount() {
    double sum = 0;
    for (var i = 0; i < CartData.myCartList.length; i++) {
      sum = sum + CartData.myCartList[i].totalPrice;
    }
    return sum;
  }

  void refresh() {
    setState(() {});
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
                                  from:
                                      CartDetailPage().runtimeType.toString())))
                      .then((value) => {Navigator.pop(context), refresh()});
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
                              from: CartDetailPage()
                                  .runtimeType
                                  .toString()))).then((value) => {
                        Navigator.pop(context),
                        Navigator.pop(context),
                        refresh()
                      });
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
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
      bottomNavigationBar: CartData.myCartList.length == 0
          ? null
          : Container(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Total Amount: ' + addTotalAmount().round().toString(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_sharp,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              if (CartData.myCartList.length == 0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Your cart is empty'),
                                ));
                              } else {
                                showBottomSheet();
                              }
                            },
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      body: CartData.myCartList.length == 0
          ? Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: CartData.myCartList.length,
              itemBuilder: (BuildContext context, int index) {
                return listItem(context, index);
              }),
    );
  }
}
