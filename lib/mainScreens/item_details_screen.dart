import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:provider/provider.dart';
import 'package:users_app/models/items.dart';

import '../assistant_methods/assistant_methods.dart';
import '../assistant_methods/cart_item_counter.dart';


class ItemDetailScreen extends StatefulWidget {
  final Items? model;
  ItemDetailScreen({
    this.model
});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  TextEditingController itemCounterConntroller =TextEditingController();

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
        title: Text(
          widget.model!.title.toString(),
          style: const TextStyle(fontFamily: "Signatra", fontSize: 45),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.model!.thumbnailUrl.toString(),),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: NumberInputPrefabbed.roundedButtons(
              controller: itemCounterConntroller,
              incDecBgColor: Colors.amber,
              max: 15,
              min: 1,
              initialValue: 1,
              buttonArrangement: ButtonArrangement.incRightDecLeft,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(),
              style: const TextStyle(
                fontFamily: "Varela",
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "₹ "+widget.model!.price.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: InkWell(
              onTap: ()
              {
                int itemCounter=int.parse(itemCounterConntroller.text);
                List<String> separateItemIDsList=seperateItemIDs();
                separateItemIDsList.contains(widget.model!.itemId)?
                    Fluttertoast.showToast(msg: "Item is Already in Cart."):
                addItemToCart(widget.model!.itemId,context,itemCounter);

              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyan,Colors.amber],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0,1.0],
                      tileMode: TileMode.clamp,
                    )
                ),
                width: MediaQuery.of(context).size.width-12,
                height: 50,
                child: const Center(
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white,fontSize: 16),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
