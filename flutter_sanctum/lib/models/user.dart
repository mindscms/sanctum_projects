class User {
  int id;
  String name;
  String email;

  User({ this.id, this.name, this.email });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );

  }

}