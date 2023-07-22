import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/models/selers.dart';
import 'package:users_app/widgets/menus_design.dart';

import '../global/global.dart';
import '../models/menus.dart';
import '../widgets/mydrawer.dart';
import '../widgets/progressbar.dart';
import '../widgets/text_widget.dart';

class MenuScreen extends StatefulWidget {

  final Sellers? model;
  MenuScreen({this.model});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: TextWidgetHeader(title: widget.model!.sellerName.toString()+"'s menu"),),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("sellers").doc(widget.model!.sellerUID).collection("menus").orderBy("publishedDate",descending: true).snapshots(),
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
                    Menus model= Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String,dynamic>,
                    );
                    return MenusDesign(
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
