class Files {
  String? name;
  String? path;
  String? creationDate;
  String? thumbnail;
  String? duration;
  String? image;

  Files({
    this.name,
    this.path,
    this.creationDate,
    this.thumbnail,
    this.duration,
    this.image,
  });

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      name: json["name"],
      path: json["path"],
      creationDate: json["creationDate"],
      thumbnail: json["thumbnail"],
      duration: json['duration'],
      image: json['image'],
    );
  }
}
