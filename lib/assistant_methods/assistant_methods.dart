import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistant_methods/cart_item_counter.dart';
import 'package:users_app/global/global.dart';

seperateItemIDs()
{
  List<String> seperateItemIDsList=[],defaultItemList=[];
  int i=0;
  defaultItemList=sharedPreferences!.getStringList("userCart")!;

  for(i;i<defaultItemList.length;i++)
    {
      String item=defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");
      String getItemId= (pos!=-1)? item.substring(0,pos):item;
      seperateItemIDsList.add(getItemId);
    }
  return seperateItemIDsList;

}


addItemToCart(String? foodItemId,BuildContext context,int itemCounter)
{
  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add("${foodItemId!}: $itemCounter");

  FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).update(
      {
        "userCart":tempList,
      }).then((value) {

        Fluttertoast.showToast(msg: "Item Added Successfully. ");

        sharedPreferences!.setStringList("userCart", tempList);

        Provider.of<CartItemCounter>(context,listen: false).displayCartListItemsNumber();
  });

}