class User {
  final String id;
  final String email;

  User({required this.id, required this.email});

  // Factory constructor om JSON te converteren naar een User-object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
    );
  }

  // Methode om een User-object om te zetten naar JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }
}
