import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_demo/database/database_collections.dart';
import 'package:hackathon_demo/dialogflow/dialog_flow_service.dart';
import 'package:hackathon_demo/translation/TranslationResponse.dart';
import 'package:hackathon_demo/translation/TranslationService.dart';
import 'package:hackathon_demo/user/storage/user_shared_pref.dart';
import 'package:hackathon_demo/widgets/chat_message_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController;
  Firestore db = Firestore.instance;
  CollectionReference reference;
  String email = "";
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    reference = db.collection(DatabaseCollections.USER_CHATS);

    UserSharedPreference.getLoggedInUserEmail().then((email) {
      this.email = email;
    });

    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Welcome !!! Let's chat...",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.8,
            child: StreamBuilder(
              stream: reference.where("email", isEqualTo: email).snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: Text(
                          "No Chat History. Start converation!!",
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      )
                    : _buildChatList(context, snapshot.data.documents);
              },
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.2,
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white, fontSize: 14, fontStyle: FontStyle.normal),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                              border: InputBorder.none,
                              hintText: "Type something",
                              hintStyle: TextStyle(
                                  color: Colors.white30, fontSize: 14, fontStyle: FontStyle.italic)),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (text) {
                            sendQuery(text);
                            _textEditingController.clear();
                            _textEditingController.clearComposing();
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          sendQuery(_textEditingController.text);
                          _textEditingController.clear();
                          _textEditingController.clearComposing();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  sendQuery(message) async {
    var detectedSourceLanguage;
    Translation t = await translateString(message, "en");
    detectedSourceLanguage = t.detectedSourceLanguage;
    reference.add({
      "email": email,
      "message": t.translatedText,
      "orig_message": message,
      "lang": t.detectedSourceLanguage,
      "created": new DateTime.now().millisecondsSinceEpoch,
      "is_sender": true
    }).then((value) {
      //scrollController.animateTo(9.0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      Provider.of<DialogFlowService>(context).request(t.translatedText).then((result) async {
        Translation t1 = await translateString(result, detectedSourceLanguage);
        reference
            .add({
              "email": email,
              "message": t1.translatedText,
              "orig_message": message,
              "lang": "en",
              "created": new DateTime.now().millisecondsSinceEpoch,
              "is_sender": false
            })
            .then((value) {})
            .catchError((e) {
              print("not added");
            });
      });
    }).catchError((e) {
      print("not added");
    });
  }

  Widget _buildChatList(BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        var data = snapshots[index].data;
        return Padding(
          padding: EdgeInsets.only(
              top: (index == 0) ? 20 : 0, bottom: (index == snapshots.length - 1) ? 20 : 0),
          child: ChatMessageWidget(
            isUser: data["is_sender"],
            message: data["message"],
            originalMessage: data["orig_message"],
            lang: data["lang"],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemCount: snapshots.length,
    );
  }
}
