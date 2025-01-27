class RecipeCategory {
  final String id;
  final String name;
  final String imageUrl;

  RecipeCategory({required this.id, required this.name, required this.imageUrl});

  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
        id: json['idCategory'] as String,
        name: json['strCategory'] as String,
        imageUrl: json['strCategoryThumb'] as String,
    );
  }
}