class AppText {
  static const String joinUs = 'JOIN US!';
  static const String theMostVarious = 'The most various trainings';
  static const String signIn = 'Sign in';
  static const String signUp = 'Sign up';
  static const String signInGoogle = 'Sign in with Google';
  static const String forgotPassword = 'Forgot password?';
  static const String dontHaveAccount = 'Dont`t have account? ';

  static const String createAccount = 'CREATE ACCOUNT';
  static const String haveAccount = 'Have an account? ';
  static const String greatOpportunity = 'Great opportunity!';
  static const String weWillSendLink =
      'We will send a link for password reset on your email';
  static const String sendEmail = 'Send email';

  static const String confirmPassword = 'Confirm password';
  static const String email = 'Email';
  static const String memberSince = 'Member since ';
  static const String username = 'Username';

  static const String home = 'Home';
  static const String feed = 'Feed';
  static const String profile = 'Profile';
  static const String editProfile = 'Edit profile';
  static const String support = 'Support';
  static const String logout = 'Logout';
  static const String yourWorkout = 'Your workouts';
  static const String password = 'Password';
  static const String editStats = 'Edit stats';

  static const String whatsGender = 'What’s your gender?';
  static const String howOld = 'How old are you?';
  static const String whatsHeight = 'What’s your height?';
  static const String whatsWeight = 'What’s your weight?';
  static const String whatTopic = 'What topics you like more?';

  static const String next = 'Next';
  static const String finish = 'Finish';
  static const String previousStep = 'Previous Step';

  static const String man = 'Man';
  static const String woman = 'Woman';
  static const String gender = 'Gender';
  static const String age = 'Age';
  static const String height = 'Height';
  static const String weight = 'Weight';
  static const String favoriteTopic = 'Favorite topics';

  static const String buildingMuscles = 'Building muscles';
  static const String loosingWeight = 'Loosing weight';
  static const String gainingWeight = 'Gaining weight';
  static const String stretching = 'Stretching';

  static const String videoPath = 'assets/videos/video.MP4';

  static  Map<String, bool> topics = {
    buildingMuscles: false,
    loosingWeight: false,
    gainingWeight: false,
    stretching: false,
  };
}

class AppVariables {
  static double currentPosition = 0.0;
  static bool first = false;
}

enum Gender {
  man,
  woman,
}
