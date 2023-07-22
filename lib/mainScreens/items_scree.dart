import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistant_methods/cart_item_counter.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/widgets/items_design.dart';

import '../global/global.dart';
import '../models/menus.dart';
import '../widgets/sellers_design.dart';
import '../widgets/mydrawer.dart';
import '../widgets/progressbar.dart';
import '../widgets/text_widget.dart';

class ItemsScreen extends StatefulWidget {
  final Menus? model;
  ItemsScreen({this.model});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan,Colors.amber],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0,1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          "SgBytez",
          style: TextStyle(fontFamily: "Signatra", fontSize: 45),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
         Stack(
           children: [
             IconButton(
                 onPressed: (){

                 },
                 icon: const Icon(Icons.shopping_cart)),
              Positioned(
                 child: Stack(
                   children: [
                     const Icon(
                       Icons.brightness_1,
                       size: 20,
                       color: Colors.green,
                     ),
                     Positioned(
                       top: 3,
                       right: 4,
                       child: Center(
                         child: Consumer<CartItemCounter>(
                           builder: (context,counter,c)
                           {
                             return Text(
                               counter.count.toString(),
                               style: const TextStyle(color: Colors.white,fontSize: 12),
                             );
                           },
                         ),
                       ),
                     ),
                   ],
                 )
             ),
           ],
         )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: "Items of ${widget.model!.menuTitle}"),),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").doc(widget.model!.sellerUID).collection("menus").doc(widget.model!.menuId).collection("items").orderBy("publishedDate",descending: true).snapshots(),
            builder: (context,snapshot)
            {
              return !snapshot.hasData? SliverToBoxAdapter(
                child: Center(child: circularProgress(),),
              )
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c)=>const StaggeredTile.fit(1),
                itemBuilder: (context,index)
                {
                  Items model= Items.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String,dynamic>,
                  );
                  return ItemDesign(
                    model: model,
                    context: context,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
