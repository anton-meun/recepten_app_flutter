import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recepten_app_flutter/features/serves/recipes_catagories_seves.dart';
import 'package:recepten_app_flutter/widgets/spinner.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecipesCatagories extends ConsumerWidget {
  const RecipesCatagories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(recipeCategoriesProvider);

    return categories.when(
      data: (data) {
        return SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = data[index];
              return Column(
                children: [
                  // Image
                  Expanded(
                    child: SizedBox(
                      width: 80,
                      child: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            imageUrl: category.imageUrl,
                            progressIndicatorBuilder: (context, url, progress) => Center(child: Spinner()),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Text
                  Text(category.name),
                ],
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 12,
            ),
            itemCount: data.length,
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => Center(child: Spinner()),
    );
  }
}
