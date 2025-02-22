
import 'package:fresh_veggies/models/cart.dart';
import 'package:fresh_veggies/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  late CatalogModel catalog;
   late CartModel cart;
  late VxNavigator navigator;
  late List<Item> items;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
  }
}