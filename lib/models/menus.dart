class Menus
{
  String? menuId;
  String? sellerUID;
  String? menuTitle;
  String? menuInfo;
  String? status;
  String? publishedDate;
  String? thumbnailUrl;

  Menus(
  {
    this.menuId,
    this.sellerUID,
    this.menuInfo,
    this.menuTitle,
    this.publishedDate,
    this.status,
    this.thumbnailUrl
}
      );
  Menus.fromJson(Map<String, dynamic> json)
  {
    menuId = json["menuId"];
    menuTitle = json["menuTitle"];
    menuInfo = json["menuInfo"];
    sellerUID = json["sellerUID"];
    status = json["status"];
    publishedDate = json["publishedDate"];
    thumbnailUrl = json["thumbnailUrl"];
  }
  Map<String,dynamic> tojson()
  {
    final Map<String,dynamic> data =Map<String,dynamic>();
    data["menuId"]=menuId;
    data["menuTitle"]=menuTitle;
    data["menuInfo"]=menuInfo;
    data["sellerUID"]=sellerUID;
    data["status"]=status;
    data["publishedDate"]=publishedDate;
    data["thumbnailUrl"]=thumbnailUrl;

    return data;
  }
}