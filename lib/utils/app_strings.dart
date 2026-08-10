class AppStrings {
  AppStrings._();

  static const String appTitle = 'Art Explorer';
  static const String appEyebrowLabel = 'Art Institute of Chicago';
  static const String tagline = '60,000 works. Open access.\nAll yours.';

  static const String urlImageBase = 'https://www.artic.edu/iiif/2/';
  static const String urlImageFilter = '/full/843,/0/default.jpg';
  static const String urlFetchBase = 'api.artic.edu';
  static const String urlFetchPath = 'api/v1/artworks/search';
  static const String fields =
      'id,title,artist_display,date_display,image_id,style_titles,place_of_origin';

  static const String continueWithGoogle = 'Continue with Google';
  static const String signInWithEmail = 'Sign in with email';
  static const String youAcceptTOS =
      'By continuing you agree to our terms of service';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String signInPrompt = 'Sign In';
  static const String back = 'Back';
  static const String signUpPrompt = 'Don\'t have an account? Sign Up';
  static const String signUp = 'Sign Up';
  static const String forgotPasswordPrompt =
      'Forgot password? Click to reset via email.';
  static const String checkEmail = 'Check email to reset password';
  static const String enterValidEmailPrompt =
      'Please enter valid email address';
  static const String enterPasswordPrompt = 'Please enter password';
  static const String checkPasswordLength =
      'Passwords must be at least 8 characters';
  static const String buttonPrevious = 'Prev';
  static const String buttonNext = 'Next';
  static const String buttonRetry = 'Retry';
  static const String errorMessage = 'Something went wrong. Please try again.';
  static const String caseInvalidCredential = 'invalid-credential';
  static const String incorrectEmail = 'Incorrect email or password.';
  static const String caseUserNotFound = 'user-not-found';
  static const String noAccountFound = 'No account found with that email.';
  static const String caseEmailAlreadyInUse = 'email-already-in-use';
  static const String accountAlreadyExists =
      'An account already exists with that email.';
  static const String caseTooManyRequests = 'too-many-requests';
  static const String tooManyAttempts =
      'Too many attempts. Please try again later.';
  static const String defaultErrorMessage =
      'Something went wrong. Please try again.';
  static const String date = 'Date';
  static const String origin = 'Origin';
  static const String movement = 'Movement';
  static const String collection = 'Collection';
  static const String source = 'Art Inst. Chicago';
  static const String saveToCollection = 'Save to collection';
  static const String removeFromCollection = 'Remove from collection';
  static const String myCollection = 'My Collection';
}
