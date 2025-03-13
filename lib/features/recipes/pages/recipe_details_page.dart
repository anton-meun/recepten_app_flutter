import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:recepten_app_flutter/entities/complete_recipe.dart';

class RecipeDetailsPage extends ConsumerStatefulWidget {
  const RecipeDetailsPage({super.key, required this.recipe});

  final CompleteRecipe recipe;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends ConsumerState<RecipeDetailsPage> {
  final int maxInstructionChars = 400;
  late TapGestureRecognizer _tapRecognizer;
  bool _isExpanded = false; // ✅ Houdt bij of de instructie is uitgevouwen

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _toggleReadMore;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _toggleReadMore() {
    setState(() {
      _isExpanded = !_isExpanded; // ✅ Toggle tussen Read More en Read Less
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool readMore = !_isExpanded &&
        widget.recipe.instructions.length > maxInstructionChars;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(IconsaxPlusBold.heart),
          )
        ],
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: widget.recipe.imageUrl,
            height: 400,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Wrap(
                  spacing: 10,
                  children: List.generate(
                    widget.recipe.tags.length,
                        (index) {
                      final tag = widget.recipe.tags[index];
                      return Chip(label: Text(tag));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 12),
                  child: Row(
                    children: [
                      const Icon(IconsaxPlusLinear.note, size: 20),
                      Text(
                        "Instructions",
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: widget.recipe.instructions.substring(
                          0,
                          readMore
                              ? maxInstructionChars
                              : widget.recipe.instructions.length,
                        ),
                      ),
                      TextSpan(
                        recognizer: _tapRecognizer,
                        text: _isExpanded ? " Read less" : " Read more...",
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.deepOrange),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Row(
                    spacing: 4,
                    children: [
                      const Icon(Icons.list_alt_rounded, size: 20),
                      Text(
                        "Ingredients",
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),

                Wrap(
                  runSpacing: 10,
                  children: List.generate(
                    widget.recipe.ingredients.length,
                        (index) {
                      final ingredient = widget.recipe.ingredients[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.deepOrange.shade800, width: 0.5), // Rand
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                ingredient.imageUrl,
                                fit: BoxFit.cover,
                                width: 45,
                                height: 45,
                              ),
                            ),
                          ),
                          title: Text(ingredient.name),
                          subtitle: Text(ingredient.measure),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
