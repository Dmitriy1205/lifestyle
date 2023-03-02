import 'package:lifestyle/data/models/group.dart';

class Workout {
  String? id;
  String? name;
  String? description;
  String? recommendation;
  String? interval;
  String? author;
  String? image;
  String? category;
  List<Group>? exercises;

  Workout({
    this.id,
    this.name,
    this.description,
    this.interval,
    this.author,
    this.image,
    this.category,
    this.exercises,
    this.recommendation,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json["name"].toString(),
      description: json["description"].toString(),
      interval: json["interval"].toString(),
      author: json["author"].toString(),
      image: json['image'].toString(),
      category: json["category"].toString(),
      exercises:
          (json['exercises'] as List).map((e) => Group.fromJson(e)).toList(),
      recommendation: json['recommendation'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "recommendation": recommendation,
      "interval": interval,
      "author": author,
      "image": image,
      "category": category,
      "exercises":
          List<dynamic>.from(exercises!.map((ex) => ex.toJson())).toList(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workout &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          recommendation == other.recommendation &&
          interval == other.interval &&
          author == other.author &&
          image == other.image &&
          exercises == other.exercises &&
          category == other.category;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      recommendation.hashCode ^
      interval.hashCode ^
      author.hashCode ^
      image.hashCode ^
      exercises.hashCode ^
      category.hashCode;
}
