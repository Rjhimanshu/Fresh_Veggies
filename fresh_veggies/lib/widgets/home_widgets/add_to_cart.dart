import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/core/store.dart';
import 'package:fresh_veggies/models/cart.dart';
import 'package:fresh_veggies/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
  const AddToCart({
    Key ? key,
    required this.catalog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(catalog);
    return ElevatedButton(
      onPressed: () {
        if (!isInCart) {
          AddMutation(catalog);
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(context.theme.buttonColor),
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          )),
      child: isInCart ? const Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus),
    );
  }
}