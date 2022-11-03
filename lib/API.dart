import 'dart:convert';

import 'package:http/http.dart' as http;

class Products {
  Future productList() async {
    var data = Uri.parse('https://fakestoreapi.com/products');
    var data2 = await http.get(data);
    var data3 = json.decode(data2.body);
    // print(data3);
    return data3;
  }
}
