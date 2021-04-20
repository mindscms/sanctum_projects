class Post {
  int id;
  String title;

  Post({ this.id, this.title });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
    );

  }

}