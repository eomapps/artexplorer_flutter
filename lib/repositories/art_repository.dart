import 'dart:convert' as convert;

import 'package:artexplorer/models/artwork.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:http/http.dart' as http;

class ArtRepository {
  Future<List<Artwork>> fetchArtworksByPage(int page) async {
    var url = Uri.https(AppStrings.urlFetchBase, AppStrings.urlFetchPath, {
      'page': '$page',
      'limit': '100',
      'fields': AppStrings.fields,
      'query[term][is_public_domain]': 'true',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];
      return (data as List)
          .map((e) => Artwork.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<Artwork>> fetchArtworksByStyleTitle(String styleTitle) async {
    var url = Uri.https(AppStrings.urlFetchBase, AppStrings.urlFetchPath, {
      'query[term][style_titles]': styleTitle,
      'limit': '100',
      'fields': AppStrings.fields,
      'query[term][is_public_domain]': 'true',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];
      return (data as List)
          .map((e) => Artwork.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<Artwork>> fetchArtworksByQuery(String query) async {
    var url = Uri.https(AppStrings.urlFetchBase, AppStrings.urlFetchPath, {
      'q': query,
      'limit': '100',
      'fields': AppStrings.fields,
      'query[term][is_public_domain]': 'true',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var data = jsonResponse['data'];
      return (data as List)
          .map((e) => Artwork.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
