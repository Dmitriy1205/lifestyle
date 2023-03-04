class Files {
  String? name;
  String? path;
  String? creationDate;
  String? thumbnail;
  String? duration;
  String? image;
  String? content;
  String? type;

  Files({
    this.name,
    this.path,
    this.creationDate,
    this.thumbnail,
    this.duration,
    this.image,
    this.content,
    this.type,
  });

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      name: json["name"].toString(),
      path: json["path"].toString(),
      creationDate: json["creationDate"].toString(),
      thumbnail: json["thumbnail"].toString(),
      duration: json['duration'].toString(),
      image: json['image'].toString(),
      content: json['content'].toString(),
      type: json['type'].toString(),
    );
  }
}
