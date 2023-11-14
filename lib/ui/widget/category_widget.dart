import 'package:flutter/material.dart';
import 'package:news_app/model/CategoryDM.dart';

class CatregoryWidget extends StatelessWidget {
  final CategoryDM categoryDM;
  final Radius radius = const Radius.circular(20);

  const CatregoryWidget({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: categoryDM.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: categoryDM.isLeftSided ? Radius.zero : radius,
              bottomRight: !categoryDM.isLeftSided ? Radius.zero : radius)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            categoryDM.imagePath,
            height: 100,
          ),
          Text(
            categoryDM.title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          )
        ],
      ),
    );
  }
}
