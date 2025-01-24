import 'package:flutter/material.dart';

class RecipesCatagories extends StatelessWidget {
  const RecipesCatagories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Text("Category $index");
        },
        separatorBuilder: (context, index) =>
            SizedBox(
              width: 12,
            ),
        itemCount: 8,
      ),
    );
  }
}