import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'package:hackathon_demo/constants/google_constants.dart';

class DialogFlow {
  static DialogFlow _instance;

  static getInstance() {
    if (_instance == null) {
      return DialogFlow();
    }

    return _instance;
  }

  DialogFlow() {
    //_instance = Dialogflow(token: GoogleConstants.GOOGLE_CLIENT_KEY);
  }
}
