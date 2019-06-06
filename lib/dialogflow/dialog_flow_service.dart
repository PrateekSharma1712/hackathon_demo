import 'package:flutter_dialogflow/flutter_dialogflow.dart';
import 'package:hackathon_demo/constants/google_constants.dart';

class DialogFlowService {

  Dialogflow dialogFlow;

  DialogFlowService() {
    dialogFlow = Dialogflow(token: GoogleConstants.GOOGLE_CLIENT_KEY);
  }

  Future<String> request(String query) async {
    AIResponse response = await dialogFlow.sendQuery(query);
    return response.getMessageResponse();
  }
}