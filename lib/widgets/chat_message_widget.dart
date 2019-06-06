import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class ChatMessageWidget extends StatelessWidget {
  final bool isUser;
  final String message;
  final String originalMessage;
  final String lang;

  ChatMessageWidget({this.isUser, this.message, this.originalMessage, this.lang});

  @override
  Widget build(BuildContext context) {
    return isUser
        ? Row(
            children: <Widget>[
              Spacer(flex: 1),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  originalMessage,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              SizedBox(width: 8),
            ],
          )
        : Row(
            children: <Widget>[
              SizedBox(width: 8),
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(),
                child: Material(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        "assets/images/icon.png",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    message,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ),
              Spacer(flex: 1),
            ],
          );
  }
}
