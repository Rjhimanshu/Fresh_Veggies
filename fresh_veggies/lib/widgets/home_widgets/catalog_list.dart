import 'package:flutter/material.dart';
import 'package:fresh_veggies/core/store.dart';
import 'package:fresh_veggies/models/catalog.dart';
import 'package:fresh_veggies/pages/home_detail_page.dart';
import 'package:fresh_veggies/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'add_to_cart.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyStore store = VxState.store;
    return Scrollbar(
      child: VxBuilder(
        mutations: const{SearchMutation},
        builder: (context, _,__) => !context.isMobile
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                itemCount: store.items.length,
                itemBuilder: (context, index) {
                  final catalog = store.items[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDetailPage(catalog: catalog),
                      ),
                    ),
                    child: CatalogItem(catalog: catalog),
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: store.items.length,
                itemBuilder: (context, index) {
                  final catalog = store.items[index];
                  return InkWell(
                    onTap: () => context.vxNav.push(
                      Uri(
                          path: MyRoutes.homeDetailsRoute,
                          queryParameters: {"id": catalog.id.toString()}),
                    ),
                    child: CatalogItem(catalog: catalog),
                  );
                },
              ),
      ),
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key ? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalog.id.toString()),
            child: CatalogImage(
              image: catalog.image,
            ),
          ),
          VxBuilder(
            mutations: {ChangeQuantity},
            builder: (context, _,__) => Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                catalog.name.text.lg.color(context.accentColor).bold.make(),
                10.heightBox,
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  buttonPadding: EdgeInsets.zero,
                  children: [
                    "\₹${catalog.totalPrice}".text.bold.xl.make(),
                    AddToCart(catalog: catalog),
                  ],
                ).pOnly(right: 8.0)
              ],
            )),
          )
        ],
      ),
    ).color(context.cardColor).rounded.square(150).make().py16();
  }
}