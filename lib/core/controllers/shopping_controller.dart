import 'package:flutter_project/core/models/product.dart';
import 'package:get/get.dart';

class ShoppingController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    await Future.delayed(Duration(seconds: 1));
    var productResult = [
      Product(
        id: 1,
        productName: "Apple iPhone 14",
        productDescription:
            "Experience the latest iPhone.",
        productImage: "assets/images/iphone14.png",
        price: 799.99,
      ),
      Product(
        id: 2,
        productName: "Samsung Galaxy S23",
        productDescription:
            "Premium Android ",
        productImage: "assets/images/galaxyS23.png",
        price: 699.99,
      ),
      Product(
        id: 3,
        productName: "Sony WH-1000XM5",
        productDescription:
            "Industry-leading ",
        productImage: "assets/images/sonyHeadphones.png",
        price: 349.99,
      ),
      Product(
        id: 4,
        productName: "Dell XPS 15 Laptop",
        productDescription:
            "High-performance ",
        productImage: "assets/images/dellXPS15.png",
        price: 1299.99,
      ),
      Product(
        id: 5,
        productName: "Nike Air Max 270",
        productDescription:
            "Stylish and ",
        productImage: "assets/images/nikeAirMax270.png",
        price: 149.99,
      ),
    ];

    products.value = productResult;
  }
}
