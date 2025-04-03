class BasicRecipe{
  final String id;
  final String name;
  final String imageUrl;

  BasicRecipe({required this.id, required this.name, required this.imageUrl});

  factory BasicRecipe.fromJson(Map<String, dynamic> json) {
    return BasicRecipe(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      imageUrl: json['strMealThumb'] as String,
    );
  }
}