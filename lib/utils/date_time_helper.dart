class DateTimeHelper {
  static String getWeekDayInString(int dayNum) {
    switch (dayNum) {
      case -1:
        return "Everyday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  static String getMonthInString(int monthNum) {
    switch (monthNum) {
      case -1:
        return "EveryMonth";
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "Ju;y";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  static String getDateTimeToDisplay(DateTime dateTime) {
    String dateTimeToDisplay = "";
    String day = getWeekDayInString(dateTime.day);
    String month = getMonthInString(dateTime.month);
    String time = getTimeInString(dateTime);
    dateTimeToDisplay = "$day in $month at $time";
    return dateTimeToDisplay;
  }

  static String getTimeInString(DateTime dateTime) {
    String time = "";
    if (dateTime.hour > 9) {
      if (dateTime.minute > 9) {
        time = "${dateTime.hour} : ${dateTime.minute}";
      } else
        time = "${dateTime.hour} : 0${dateTime.minute}";
    } else {
      if (dateTime.minute > 9) {
        time = "0${dateTime.hour} : ${dateTime.minute}";
      } else
        time = "0${dateTime.hour} : 0${dateTime.minute}";
    }
    return time;
  }

  static String getDateInString(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    return "$day ${getMonthInString(month)} $year";
  }
}
