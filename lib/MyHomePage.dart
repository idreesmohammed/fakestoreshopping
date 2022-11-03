import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'API.dart';
import 'CartData.dart';
import 'CartDetailPage.dart';
import 'ProductDetailPage.dart';
import 'package:badges/badges.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data2;
  String _text = "";

  @override
  void initState() {
    Products().productList().then((value) {
      setState(() {
        data2 = value;
      });
    });
    super.initState();
  }

  var data3;
  onClickHomeItem(context, index) {
    data3 = data2[index];
    print("OnItemClicked=> " + data3.toString() + index.toString());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                totalProductionDescription: data3,
                index: index))).then((value) => addCartNumber());
  }

  void addCartNumber() {
    _text = CartData.myCartList.length.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Amazon Shopping',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              print('size: ' + MediaQuery.of(context).size.width.toString());
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Badge(
              showBadge: CartData.myCartList.length == 0 ? false : true,
              badgeColor: Colors.white,
              position: BadgePosition.topEnd(top: 0, end: 1),
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
          ),
        ],
      ),
      body: data2 == null
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.grey,
            ))
          : Container(
              child: GridView.builder(
                  padding: EdgeInsets.all(5.0),
                  itemCount: data2.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        onClickHomeItem(context, index);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 3),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 15.0),
                                    blurRadius: 20.0,
                                  ),
                                ]),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Image.network(data2[index]["image"]),
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                    data2[index]["title"],
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                    'Price: ' +
                                        double.parse(data2[index]["price"]
                                                .toString())
                                            .round()
                                            .toString(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                                Expanded(
                                  child: Center(
                                      child: (Text(data2[index]['category'],
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          )))),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
