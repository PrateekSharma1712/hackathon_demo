class User {
  String _name, _email;
  String _uid, _profilePic;


  User(this._name, this._email);


  get profilePic => _profilePic;

  set profilePic(value) {
    _profilePic = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }


  get email => _email;

  set email(value) {
    _email = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


}