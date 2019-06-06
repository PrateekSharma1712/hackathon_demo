import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon_demo/database/database_collections.dart';
import 'package:hackathon_demo/user/model/user_model.dart';
import 'package:hackathon_demo/user/storage/user_shared_pref.dart';

class LoginServer {
  String email;
  String password;
  DocumentReference reference;

  LoginServer.name(email, password, this.reference);

  LoginServer();

  LoginServer.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['email'] != null),
        assert(map['password'] != null),
        email = map['email'],
        password = map['password'];

  LoginServer.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Future handleSignIn(String email, String password) async {
    var complete = Completer();
    final FirebaseAuth mAuth = FirebaseAuth.instance;
    await mAuth
        .signInWithEmailAndPassword(
            email: email.toLowerCase(), password: password)
        .then((user) {
      fetchUserDataByEmail(email.toLowerCase()).then((b) {
        if (b == "error") {
          complete.complete("error");
        } else if (b == "no_user_data") {
          complete.complete("no_user_data");
        } else
          complete.complete(b);
      });
    }).catchError((error) {
//      complete.completeError(error);
      handleSignUp(email, password).then((value) {
        complete.complete(value);
      }).catchError((e) {
        complete.completeError(e);
      });
    });
    return complete.future;
  }

  handleSignUp(String email, String password) async {
    var complete = Completer();
    final FirebaseAuth mAuth = FirebaseAuth.instance;
    await mAuth
        .createUserWithEmailAndPassword(
            email: email.toLowerCase(), password: password)
        .then((user) {
      UserSharedPreference.updateLoggedInUserEmail(email);
      complete.complete(user);
    }).catchError((error) {
      complete.complete(error);
    });
    return complete.future;
  }

  uploadUserData(email, name) async {
    var complete = Completer();
    Firestore db = Firestore.instance;
    final TransactionHandler userDetailTransactionHandler =
        (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(
          db.collection(DatabaseCollections.USER_COLLECTION).document(email));
      var dataMap = new Map<String, dynamic>();
      dataMap['name'] = name;
      dataMap['email'] = email.toString().toLowerCase();
      dataMap['profile_pic'] = "";
      dataMap['created'] = new DateTime.now().millisecondsSinceEpoch.toString();
      dataMap['updated'] = new DateTime.now().millisecondsSinceEpoch.toString();
      await tx.set(ds.reference, dataMap);
      return dataMap;
    };
    Firestore.instance
        .runTransaction(userDetailTransactionHandler)
        .then((value) {
      print("upload complete");

      complete.complete(true);
    }).catchError((error) {
      print("upload user data error");
      complete.complete(false);
    });
    return complete.future;
  }

  updateUserData(String email, String name, String workshopNum,
      String mobileNum, String profilePic) async {
    var complete = Completer();
    Firestore db = Firestore.instance;
    final TransactionHandler userDetailTransactionHandler =
        (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(
          db.collection(DatabaseCollections.USER_COLLECTION).document(email));
      var dataMap = new Map<String, dynamic>();
      dataMap['name'] = name;
      dataMap['workshop_num'] = workshopNum;
      dataMap['mobile_num'] = mobileNum;
      if (profilePic != null && profilePic != "")
        dataMap['profile_pic'] = profilePic;
      dataMap['updated'] = new DateTime.now().millisecondsSinceEpoch.toString();
      await tx.update(ds.reference, dataMap);
      return dataMap;
    };
    Firestore.instance
        .runTransaction(userDetailTransactionHandler)
        .then((value) {
      print("upload complete");

      complete.complete(true);
    }).catchError((error) {
      print("update user data error");
      complete.complete(false);
    });
    return complete.future;
  }

  fetchUserDataByEmail(email) async {
    Completer complete = Completer();
    Firestore db = Firestore.instance;
    CollectionReference userRef =
        db.collection(DatabaseCollections.USER_COLLECTION);
    await userRef.where("email", isEqualTo: email).getDocuments().then((value) {
      print(value);
      var data = value.documents[0].data;
      if (data != null) {
        var name = data["name"];
        var email = data["email"];
        User user = User(name, email);
        user.uid = value.documents[0].documentID;
        complete.complete(user);
      } else {
        complete.complete("no_user_data");
      }
    }).catchError((error) {
      print(error);
      if (error.message == "Invalid value") {
        complete.complete("no_user_data");
      } else
        complete.complete("error");
    });
    return complete.future;
  }

  sendForgetPasswordEmail(email) async {
    Completer completer = Completer();
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((isSend) {
      completer.complete(true);
    }).catchError((error) {
      completer.complete(false);
    });
    return completer.future;
  }
}
