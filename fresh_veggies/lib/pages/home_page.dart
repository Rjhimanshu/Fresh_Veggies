import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_veggies/core/store.dart';
import 'package:fresh_veggies/models/cart.dart';
import 'package:fresh_veggies/models/catalog.dart';
import 'package:fresh_veggies/utils/routes.dart';
import 'package:fresh_veggies/widgets/drawer.dart';
import 'package:fresh_veggies/widgets/home_widgets/catalog_header.dart';
import 'package:fresh_veggies/widgets/home_widgets/catalog_list.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    loadData();
    setState(() {
      
    });
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
    await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    (VxState.store as MyStore).items = CatalogModel.items;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    final _cart = (VxState.store as MyStore).cart;


    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
          backgroundColor: context.canvasColor,
          drawer: MyDrawer(),
          appBar: AppBar( 
          leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          title: "Fresh Veggies".text.xl4.bold.color(context.theme.accentColor).make(),
          ),
    
    
           floatingActionButton: VxBuilder(
            mutations: {AddMutation, RemoveMutation},
            builder: (ctx, _,__) => FloatingActionButton(
              onPressed: () => context.vxNav.push(Uri.parse(MyRoutes.cartRoute)),
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
          
          body: SafeArea(
            child: Container(
              padding: Vx.m32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CatalogHeader(),
                  CupertinoSearchTextField(
                    onChanged: (value) {
                      SearchMutation(value);
                    },
                  ).py12(),
                  if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                    CatalogList().py16().expand()
                  else
                    const CircularProgressIndicator().centered().expand(),
                ],
              ),
            ),
            
          ),
           
          ),
    );
  }
}