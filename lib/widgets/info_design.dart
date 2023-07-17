import 'package:flutter/material.dart';
import 'package:users_app/models/selers.dart';
class InfoDesign extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  InfoDesign({this.model, this.context});


  @override
  State<InfoDesign> createState() => _InfoDesignState();
}

class _InfoDesignState extends State<InfoDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
