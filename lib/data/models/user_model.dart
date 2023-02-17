import 'package:lifestyle/data/models/profile.dart';
import 'package:lifestyle/data/models/workout.dart';

class UserModel {
  final List<Workout>? workouts;
  final List<ProfileModel>? profile;

  UserModel({this.workouts, this.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      workouts:
          (json["Workouts"] as List).map((i) => Workout.fromJson(i)).toList(),
      profile: List.of(json["Profile"])
          .map((i) => ProfileModel.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "workouts":
          List<dynamic>.from(workouts!.map((ex) => ex.toJson())).toList(),
      "profile": List<dynamic>.from(profile!.map((ex) => ex.toJson())).toList(),
    };
  }
//

}
