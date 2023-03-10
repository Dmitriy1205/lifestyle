class AppText {
  static const String joinUs = 'JOIN US!';
  static const String theMostVarious = 'The most various trainings';
  static const String signIn = 'Sign in';
  static const String signUp = 'Sign up';
  static const String signInGoogle = 'Sign in with Google';
  static const String forgotPassword = 'Forgot password?';
  static const String dontHaveAccount = 'Dont`t have an account? ';

  static const String createAccount = 'CREATE ACCOUNT';
  static const String haveAccount = 'Have an account? ';
  static const String greatOpportunity = 'Great opportunity!';
  static const String weWillSendLink =
      'We will send a link for password reset on your email';
  static const String sendEmail = 'Send email';
  static const String noConnection = 'No internet connection';
  static const String checkYourConnection = 'Check Your Internet connection';
  static const String connected = 'Internet connection restored';

  static const String confirmPassword = 'Confirm password';
  static const String email = 'Email';
  static const String memberSince = 'Member since ';
  static const String username = 'Username';

  static const String home = 'Home';
  static const String gym = 'Gym';
  static const String all = 'All';
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
  static const String whatTopic = 'Specify your goals';

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
  static const String workoutCategory = 'Workout Category';

  static const String buildingMuscles = 'Building muscles';
  static const String loosingWeight = 'Loosing weight';
  static const String gainingWeight = 'Gaining weight';
  static const String stretching = 'Stretching';
  static const String healthDirectory = 'Health directory';
  static const String workouts = 'Workouts';
  static const String goals = 'Goals';
  static const String lifestyle = 'LIFESTYLE';
  static const String forToday = 'For today';
  static const String neww = 'New';
  static const String articles = 'Articles';
  static const String forYou = 'For you';
  static const String exercises = 'Exercises';
  static const String mealsRecommendations = 'Meal recommendations';
  static const String trainingName = 'Training name';
  static const String description = 'Description';
  static const String training = 'Training';
  static const String rest = 'Rest';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String create = 'Create';
  static const String relaxTime = 'Relax Time';
  static const String trainings = 'TRAINING';
  static const String search = 'Search';
  static const String seconds = 'Seconds';
  static const String minutes = 'Minutes';
  static const String unit = 'Unit';
  static const String videos = 'Videos';
  static const String vitamins = 'Vitamins';
  static const String minerals = 'Minerals';
  static const String probiotics = 'Probiotics';
  static const String exercise = 'Exercise';
  static const String sleep = 'Sleep';
  static const String remedies = 'Remedies';
  static const String fitness = 'Fitness';
  static const String chooseWorkoutCategory = 'Сhoose workout category';
  static const String warningText =
      '* It\'s important to speak with your physician before using any of these herbs as single treatment option *';

  //video
  static const String videoPath = 'assets/videos/video.MP4';

  //images
  static const String train1 = 'assets/images/train1.png';
  static const String train2 = 'assets/images/train2.png';
  static const String train3 = 'assets/images/train3.png';
  static const String train4 = 'assets/images/train4.png';
  static const String train5 = 'assets/images/train5.png';
  static const String train6 = 'assets/images/train6.png';
  static const String excercise1 = 'assets/images/exercise1.gif';
  static const String excercise2 = 'assets/images/exercise2.gif';

  static Map<String, bool> topics = {
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

enum WorkoutCategory {
  gym,
  home,
}
