class TranslationResponse {
  Data data;

  TranslationResponse({this.data});

  TranslationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Translation> translations;

  Data({this.translations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = new List<Translation>();
      json['translations'].forEach((v) {
        translations.add(new Translation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.translations != null) {
      data['translations'] = this.translations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translation {
  String translatedText;
  String detectedSourceLanguage;

  Translation({this.translatedText, this.detectedSourceLanguage});

  Translation.fromJson(Map<String, dynamic> json) {
    translatedText = json['translatedText'];
    detectedSourceLanguage = json['detectedSourceLanguage'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['translatedText'] = this.translatedText;
    data['detectedSourceLanguage'] = this.detectedSourceLanguage;
    return data;
  }
}