class AppStrings {
  AppStrings._();

  static const String appTitle = 'Art Explorer';
  static const String appEyebrowLabel = 'Art Institute of Chicago';
  static const String tagline = '60,000 works. Open access.\nAll yours.';

  static const String urlImageBase = 'https://www.artic.edu/iiif/2/';
  static const String urlImageFilter = '/full/843,/0/default.jpg';
  static const String urlFetchBase = 'https://api.artic.edu/';
  static const String urlFetchPath = 'api/v1/artworks/search';
  static const String fields =
      'id,title,artist_display,date_display,image_id,style_titles,place_of_origin';

  static const String continueWithGoogle = 'Continue with Google';
  static const String signInWithEmail = 'Sign in with email';
  static const String youAcceptTOS =
      'By continuing you agree to our terms of service';
  static const String email = 'Email';
  static const String emailExample = 'hello@example.com';
  static const String password = 'Password';
  static const String passwordExample = '••••••••';
  static const String signInPrompt = 'Sign In';
  static const String back = 'Back';
}
