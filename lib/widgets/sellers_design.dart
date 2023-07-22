import 'package:flutter/material.dart';
import 'package:users_app/mainScreens/menus_screen.dart';
import 'package:users_app/models/selers.dart';


class SellersDesign extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  SellersDesign({this.model, this.context});


  @override
  State<SellersDesign> createState() => _SellersDesignState();
}

class _SellersDesignState extends State<SellersDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>MenuScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 265,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                  widget.model!.sellerAvatarURL!,
                height: 220,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10,),
              Text(
                widget.model!.sellerName!,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Train",
                  fontSize: 20,
                ),
              ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
