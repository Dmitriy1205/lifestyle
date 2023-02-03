import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:lifestyle/data/repositories/auth_repository.dart';
import 'package:lifestyle/presentation/bloc/google_auth/google_auth_cubit.dart';

import '../../presentation/bloc/auth/auth_cubit.dart';
import '../../presentation/bloc/profile/profile_cubit.dart';
import '../../presentation/bloc/reset_password/reset_password_cubit.dart';
import '../../presentation/bloc/sign_in/sign_in_cubit.dart';
import '../../presentation/bloc/sign_up/sign_up_cubit.dart';
import '../../presentation/bloc/welcome/welcome_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  //Repositories
  sl.registerLazySingleton(() => AuthRepository(auth: auth));

  //Blocs
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  sl.registerFactory(() => SignInCubit(authRepository: sl()));
  sl.registerFactory(() => SignUpCubit(authRepository: sl()));
  sl.registerFactory(() => GoogleAuthCubit(authRepository: sl()));
  sl.registerFactory(() => ProfileCubit(authRepository: sl()));
  sl.registerFactory(() => ResetPasswordCubit(authRepository: sl()));
  sl.registerFactory(() => WelcomeCubit());
}
