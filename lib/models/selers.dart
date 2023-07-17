import 'dart:convert';

class Sellers
{
  String? sellerUID;
  String? sellerName;
  String? sellerAvatarURL;
  String? sellerEmail;

  Sellers(
  {
    this.sellerAvatarURL,
    this.sellerEmail,
    this.sellerName,
    this.sellerUID,
});

  Sellers.fromJson(Map<String,dynamic>json)
  {
    sellerUID=json["sellerUID"];
    sellerName=json["sellerName"];
    sellerAvatarURL=json["sellerAvatarURL"];
    sellerEmail=json["sellerEmail"];

  }
  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["sellerUID"]= this.sellerUID;
    data["sellerName"]= this.sellerName;
    data["sellerAvatarURL"]= this.sellerAvatarURL;
    data["sellerEmail"]= this.sellerEmail;

    return data;
  }
}