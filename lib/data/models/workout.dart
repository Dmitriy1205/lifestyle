class Workout {
  final String? name;
  final String? description;
  final String? interval;
  final String? author;
  final String? image;
  final List? exercises;

  Workout({
    this.name,
    this.description,
    this.interval,
    this.author,
    this.image,
    this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json["name"],
      description: json["description"],
      interval: json["interval"],
      author: json["author"],
      image: json['image'],
      exercises: json['exercises'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "description": this.description,
      "interval": this.interval,
      "author": this.author,
      'image': this.image,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workout &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          interval == other.interval &&
          author == other.author &&
          image == other.image;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      interval.hashCode ^
      author.hashCode ^
      image.hashCode;
}
