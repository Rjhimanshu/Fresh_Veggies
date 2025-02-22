import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_veggies/core/store.dart';
import 'package:fresh_veggies/models/cart.dart';
import 'package:fresh_veggies/models/catalog.dart';
import 'package:fresh_veggies/utils/routes.dart';
import 'package:fresh_veggies/widgets/home_widgets/add_to_cart.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        backgroundColor: context.canvasColor,
        bottomNavigationBar: Container(
          color: context.cardColor,
          child: ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.zero,
            children: [
              "\₹${catalog.price}".text.bold.xl4.red800.make(),
              AddToCart(
                catalog: catalog,
              ).wh(120, 50),
              
               VxBuilder(
              mutations: const {AddMutation, RemoveMutation},
              builder: (ctx, _,__) => FloatingActionButton(
                onPressed: () { context.vxNav.push(Uri.parse(MyRoutes.cartRoute));
                },
                backgroundColor: context.theme.buttonColor,
                child: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ),
              ).badge(
                  color: Vx.red500,
                  size: 22,
                  count: _cart.items.length,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
             ),
    
            ],
          ).p32(),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Hero(
                tag: Key(catalog.id.toString()),
                child: Image.asset(catalog.image),
              ).h32(context),
              Expanded(
                  child: VxArc(
                height: 30.0,
                arcType: VxArcType.CONVEY,
                edge: VxEdge.TOP,
                child: Container(
                  color: context.cardColor,
                  width: context.screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(

                      children: [
                        catalog.name.text.xl4
                            .color(context.accentColor)
                            .bold
                            .make(),
                        
                        10.heightBox,
                        catalog.desc.text.size(12).caption(context).xl.make(),
                       
                      ],
                    ).py64().scrollVertical(),
                  ),
                ),
              ))
            ],
          )
        ),
      ),
    );
  }
}