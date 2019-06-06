
class Validator {
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  static bool validateEmailForBool(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  static bool validateEmailExtension(String email) {
//    var splits = email.split("@");
//    if (splits[1] == InstituteInfo.INSTITUTE_EMAIL_EXTENSION) {
//      return true;
//    }
    return false;
  }

  static String validatePassword(String value) {
    if (value.length < 6)
      return 'Password  must be 6 digit';
    else
      return null;
  }

  static bool validatePasswordForBool(String value) {
// Indian Mobile number are of 6 digit only
    if (value.length < 6)
      return false;
    else
      return true;
  }

  static String valiateTitleText(String value) {
    if (value.length < 2) {
      return "Title can't be less than 2 alphabets";
    }
    return null;
  }


  static String validateDescriptionText(String value) {
    if (value.length < 10) {
      return "Dscription can't be less than 10 alphabets";
    }
    return null;
  }
}
