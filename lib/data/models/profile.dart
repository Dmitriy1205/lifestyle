class ProfileModel {
  final int? age;
  final String? gender;
  final int? height;
  final int? weight;
  final Map<String, dynamic>? topics;

  ProfileModel({
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.topics,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      age: int.parse(json["age"]),
      gender: json["gender"],
      height: int.parse(json["height"]),
      weight: int.parse(json["weight"]),
      topics: json["topics"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "age": age,
      "gender": gender,
      "height": height,
      "weight": weight,
      "topics": topics,
    };
  }
}
