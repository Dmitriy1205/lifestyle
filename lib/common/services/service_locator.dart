import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';
import 'package:lifestyle/presentation/bloc/create_profile/tags/tags_cubit.dart';
import 'package:lifestyle/presentation/bloc/google_auth/google_auth_cubit.dart';
import 'package:lifestyle/presentation/bloc/image_picker/image_picker_cubit.dart';
import 'package:lifestyle/presentation/bloc/profile/create_workout/create_workout_cubit.dart';
import 'package:lifestyle/presentation/bloc/profile/exercise_builder/exercise_builder_cubit.dart';
import 'package:lifestyle/presentation/bloc/video_player/video_player_cubit.dart';

import '../../data/repositories/data_repository.dart';
import '../../data/repositories/storage_repository.dart';
import '../../presentation/bloc/auth/auth_cubit.dart';
import '../../presentation/bloc/create_profile/age/age_cubit.dart';
import '../../presentation/bloc/create_profile/gender/gender_cubit.dart';
import '../../presentation/bloc/create_profile/height/height_cubit.dart';
import '../../presentation/bloc/create_profile/weight/weight_cubit.dart';
import '../../presentation/bloc/home/health_directory/health_cubit.dart';
import '../../presentation/bloc/home/home_cubit.dart';
import '../../presentation/bloc/home/search_screen/search_cubit.dart';
import '../../presentation/bloc/home/workout/workout_cubit.dart';
import '../../presentation/bloc/profile/edit_profile/edit_profile_cubit.dart';
import '../../presentation/bloc/profile/edit_workout/edit_workout_cubit.dart';
import '../../presentation/bloc/profile/profile_cubit.dart';
import '../../presentation/bloc/profile/your_workout/your_workout_cubit.dart';
import '../../presentation/bloc/reset_password/reset_password_cubit.dart';
import '../../presentation/bloc/sign_in/sign_in_cubit.dart';
import '../../presentation/bloc/sign_up/sign_up_cubit.dart';
import '../../presentation/bloc/welcome/welcome_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  // InternetConnectionChecker internetChecker =
  //     InternetConnectionChecker.createInstance(
  //   checkTimeout: const Duration(seconds: 1),
  //   checkInterval: const Duration(seconds: 1),
  // );

  //Connection
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(seconds: 1),
        checkInterval: const Duration(seconds: 1),
      ));

  //Repositories
  sl.registerLazySingleton(() => AuthRepository(auth: auth));
  sl.registerLazySingleton(() => DataRepository(
        db: db,
      ));
  sl.registerLazySingleton(() => StorageRepository(storage: storage));

  //Blocs
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  sl.registerFactory(() => SignInCubit(authRepository: sl()));
  sl.registerFactory(() => SignUpCubit(authRepository: sl(), db: sl()));
  sl.registerFactory(() => GoogleAuthCubit(auth: sl()));
  sl.registerFactory(
      () => ProfileCubit(auth: sl(), db: sl(), connectionChecker: sl()));
  sl.registerFactory(() => ResetPasswordCubit(authRepository: sl()));
  sl.registerFactory(() => WelcomeCubit());
  sl.registerFactory(() => GenderCubit(db: sl(), auth: sl()));
  sl.registerFactory(() => TagsCubit(db: sl(), auth: sl()));
  sl.registerFactory(() => AgeCubit(db: sl(), auth: sl()));
  sl.registerFactory(() => HeightCubit(db: sl(), auth: sl()));
  sl.registerFactory(() => WeightCubit(db: sl(), auth: sl()));
  sl.registerFactory(
      () => CreateWorkoutCubit(db: sl(), auth: sl(), storage: sl(), connectionChecker: sl()));
  sl.registerFactory(() => YourWorkoutCubit(db: sl(), auth: sl()));
  sl.registerFactory(
      () => EditWorkoutCubit(db: sl(), auth: sl(), storage: sl(), connectionChecker: sl()));
  sl.registerFactory(() => ImagePickerCubit(auth: sl(), storage: sl()));
  sl.registerFactory(() => WorkoutCubit(db: sl()));
  sl.registerFactory(() => ExerciseBuilderCubit(storage: sl(), db: sl()));
  sl.registerFactory(
      () => HealthCubit(storage: sl(), db: sl(), connectionChecker: sl()));
  sl.registerFactory(() => VideoPlayerCubit());
  sl.registerFactory(
      () => EditProfileCubit(db: sl(), auth: sl(), storage: sl(), connectionChecker: sl()));
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => SearchCubit(
        db: sl(),
        connectionChecker: sl(),
      ));
}
