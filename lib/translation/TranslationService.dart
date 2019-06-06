import 'dart:convert';
import 'package:hackathon_demo/constants/google_constants.dart';
import 'package:hackathon_demo/translation/TranslationResponse.dart';
import 'package:http/http.dart' as http;
//en for english
Future<Translation> translateString(String source, String languageCode) async {
  String url =
      "https://translation.googleapis.com/language/translate/v2?target=${languageCode}&key=${GoogleConstants.TRANSLATION_API_KEY}&q=${source}";

  var response = await http.get(url);
  var jsonResponse = json.decode(response.body);
  TranslationResponse translationResponse =
      TranslationResponse.fromJson(jsonResponse);
  Translation translation = translationResponse.data.translations[0];
  return translation;
}
