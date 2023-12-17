import 'package:intl/intl.dart';

//this basically is to convert date/day/time from calendar to string
class DateConverted {
  static String getDate(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  static String getDay(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }

  static String getTime(int time) {
    switch (time) {
      case 0:
        return '06:00:00';
      case 1:
        return '06:30:00';
      case 2:
        return '07:00:00';
      case 3:
        return '07:30:00';
      case 4:
        return '08:00:00';
      case 5:
        return '08:30:00';
      case 6:
        return '09:00:00';
      case 7:
        return '09:30:00';
      case 8:
        return '10:00:00';
      case 9:
        return '10:30:00';
      case 10:
        return '11:00:00';
      case 11:
        return '11:30:00';
      case 12:
        return '12:00:00';
      case 13:
        return '12:30:00';
      case 14:
        return '13:00:00';
      case 15:
        return '13:30:00';
      case 16:
        return '14:00:00';
      case 17:
        return '14:30:00';
      case 18:
        return '15:00:00';
      case 19:
        return '15:30:00';
      case 20:
        return '16:00:00';
      case 21:
        return '16:30:00';
      case 22:
        return '17:00:00';
      case 23:
        return '17:30:00';
      case 24:
        return '18:00:00';
      case 25:
        return '18:30:00';
      case 26:
        return '19:00:00';
      case 27:
        return '19:30:00';
      case 28:
        return '20:00:00';
      case 29:
        return '20:30:00';
      case 30:
        return '21:00:00';
      case 31:
        return '21:30:00';
      case 32:
        return '22:00:00';
      case 33:
        return '22:30:00';
      case 34:
        return '23:00:00';
      case 35:
        return '23:30:00';
      // case 36:
      //   return '24:00:00';
      default:
        return '06:00:00';
    }
  }
}