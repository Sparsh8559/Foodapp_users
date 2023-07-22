import 'package:cloud_firestore/cloud_firestore.dart';

class Items
{
  String? menuId;
  String? sellerUID;
  String? itemId;
  String? title;
  String? shortInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? longDescription;
  String? status;
  int? price;

  Items(
      {
        this.menuId,
        this.sellerUID,
        this.itemId,
        this.title,
        this.publishedDate,
        this.status,
        this.thumbnailUrl,
        this.longDescription,
        this.shortInfo
      }
      );
  Items.fromJson(Map<String, dynamic> json)
  {
    menuId = json["menuId"];
    title = json["title"];
    itemId = json["itemId"];
    sellerUID = json["sellerUID"];
    status = json["status"];
    publishedDate = json["publishedDate"];
    thumbnailUrl = json["thumbnailUrl"];
    longDescription = json["longDescription"];
    shortInfo = json["shortInfo"];
    price = json["price"];

  }
  Map<String,dynamic> tojson()
  {
    final Map<String,dynamic> data =Map<String,dynamic>();
    data["menuId"]=menuId;
    data["title"]=title;
    data["itemId"]=itemId;
    data["sellerUID"]=sellerUID;
    data["status"]=status;
    data["publishedDate"]=publishedDate;
    data["thumbnailUrl"]=thumbnailUrl;
    data["longDescription"]=longDescription;
    data["shortInfo"]=shortInfo;
    data["price"]=price;

    return data;
  }
}