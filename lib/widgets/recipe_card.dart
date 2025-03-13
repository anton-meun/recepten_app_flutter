import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recepten_app_flutter/widgets/spinner.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.onTap});

  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Card.filled(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, progress) =>
                      Center(child: Spinner()),
                ),
              ),
            ),
          ),
        ),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    ),
    );
  }
}
