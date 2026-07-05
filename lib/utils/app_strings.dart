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
}
