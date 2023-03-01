class ProfileModel {
  int age;
  String gender;
  int height;
  int weight;
  Map<String, dynamic> topics;
  String? image;
  String? name;

  ProfileModel({
    this.age = 18,
    this.gender = 'none',
    this.height = 140,
    this.weight = 40,
    this.topics = const {
      'Building muscles': false,
      'Loosing weight': false,
      'Gaining weight': false,
      'Stretching': false,
    },
    this.image,
    this.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      age: json["age"] ?? 18,
      gender: json["gender"] ?? 'null',
      height: json["height"] ?? 140,
      weight: json["weight"] ?? 40,
      topics: json["topics"] ??
          {
            'Building muscles': false,
            'Loosing weight': false,
            'Gaining weight': false,
            'Stretching': false,
          },
      image: json["image"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "age": age,
      "gender": gender,
      "height": height,
      "weight": weight,
      "topics": topics,
      "image": image,
      "name": name,
    };
  }
}

class Topic {
  bool? buildingMuscles;
  bool? gainingWeight;
  bool? loosingWeight;
  bool? stretching;

  Topic({
    this.buildingMuscles,
    this.gainingWeight,
    this.loosingWeight,
    this.stretching,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      buildingMuscles: json["Building muscles"] == 'true',
      gainingWeight: json["Gaining weight"] == 'true',
      loosingWeight: json["Loosing weight"] == 'true',
      stretching: json["Stretching"] == 'true',
    );
  }
//

}
