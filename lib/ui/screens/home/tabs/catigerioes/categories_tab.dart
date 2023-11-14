import 'package:flutter/material.dart';
import 'package:news_app/model/CategoryDM.dart';
import 'package:news_app/ui/widget/category_widget.dart';

class CategoriesTab extends StatelessWidget {
  final Function oncategoryclick;

  const CategoriesTab(this.oncategoryclick, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(12),
          child: const Text(
            "pick your category of inerest",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
          ),
        ),
        Expanded(
          child: GridView.builder(
              itemCount: CategoryDM.categotries.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    oncategoryclick(CategoryDM.categotries[index]);
                  },
                  child: CatregoryWidget(
                    categoryDM: CategoryDM.categotries[index],
                  ),
                );
              }),
        )
      ],
    );
  }
}
