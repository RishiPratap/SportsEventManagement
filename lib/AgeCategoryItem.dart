import 'package:ardent_sports/AgeCategoryDataClass.dart';
import 'package:flutter/material.dart';

class AgeCategoryItem extends StatelessWidget {
  final AgeCategoryDataClass data;
  final onDeleteItem;

  const AgeCategoryItem({
    Key? key,
    required this.data,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("  "),
              Image(image: AssetImage("assets/Menu.png")),
              Text(
                "   ${data.AgeCategory!} ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                " ${data.Category!}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              onDeleteItem(data.Category, data.AgeCategory);
            },
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.delete,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
