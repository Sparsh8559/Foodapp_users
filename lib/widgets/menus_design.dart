import 'package:flutter/material.dart';
import 'package:users_app/mainScreens/items_scree.dart';
import 'package:users_app/models/menus.dart';

class MenusDesign extends StatefulWidget {
  Menus? model;
  BuildContext? context;

  MenusDesign({this.model, this.context});


  @override
  State<MenusDesign> createState() => _MenusDesignState();
}

class _MenusDesignState extends State<MenusDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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
                widget.model!.thumbnailUrl!,
                height: 220,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10,),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Train",
                  fontSize: 20,
                ),
              ),
              Text(
                widget.model!.menuInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
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
