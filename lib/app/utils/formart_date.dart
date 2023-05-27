import 'package:intl/intl.dart';

String convert(int timestamp) {
  final format = DateFormat('d/M/y HH:mm a');
  final date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);

  final dateFormated = format.format(date);

  return dateFormated;
}

String convertFromString(String dateString) {
  if (dateString == "" ) return "";
  final format = DateFormat('dd/MM/yyyy');
  final date = DateTime.parse(dateString);

  final dateFormated = format.format(date);

  return dateFormated;
}

String formatDate(String date) {
    return date.substring(0, 5);
  }

String convertFromLastAcess(String dateString) {
  final format = DateFormat('dd/MM');
  final date = DateTime.parse(dateString);

  final dateFormated = format.format(date);

  return dateFormated;
}

String getDate(int timestamp) {
  final date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  final formatCompable = DateFormat('d/M/y');
  
  final dateFormated = formatCompable.format(date).toString();
  return dateFormated;
  
}

// int getDate() {
//   var now = new DateTime.now();
//   var timestampNow = now.millisecondsSinceEpoch;
//   // final format = new DateFormat('HH:mm a');
//   // final dateFormated = format.format(now);
 
//   return timestampNow;
// }

String differenceDate(int date) {
  final formatCompable = DateFormat('d/M/y');

  final date1 = DateTime.fromMillisecondsSinceEpoch(date);
  final date2 = DateTime.now();

  if(date2.difference(date1).inMinutes < 60){
    final difference = date2.difference(date1).inMinutes;
    return ' $difference m';

  }else if(date2.difference(date1).inHours < 24){
    final difference = date2.difference(date1).inHours;
    return ' $difference H';

  }else{
    return formatCompable.format(date1);
  }
}

String differenceDateWithString(String dateString) {
  final formatCompable = DateFormat('dd/MM');

  int date = (DateTime.parse(dateString)).millisecondsSinceEpoch;
  final date1 = DateTime.fromMillisecondsSinceEpoch(date);
  final date2 = DateTime.now();

  if(date2.difference(date1).inSeconds < 60){
    return 'agora';

  }else if(date2.difference(date1).inMinutes < 60){
    final difference = date2.difference(date1).inMinutes;
    return 'há $difference min';

  }else if(date2.difference(date1).inHours < 24){
    final difference = date2.difference(date1).inHours;
    return 'há $difference horas';

  }else if(date2.difference(date1).inDays <= 7){
    final difference = date2.difference(date1).inDays;
    return 'há $difference dias';

  }else{
    return formatCompable.format(date1);
  }
}

String timeAttendment(int date) {
  //1634643537000
  final date1 = DateTime.fromMillisecondsSinceEpoch(1634643537000);
  final date2 = DateTime.now();
  

  int difference = date2.difference(date1).inSeconds;
  int days =0;
  int hours =0;
  int minutes =0;
  
  String dateFormamted = "";

  if(difference~/86400 > 0){
    days = difference~/86400;
    difference = difference%86400;
    
    dateFormamted = "$days dias";
  }

  if(difference~/3600 > 0){
    hours = difference~/3600;
    difference = difference%3600;

    dateFormamted += " $hours horas";
  }

  if(difference~/60 > 0){
    minutes = difference~/60;
    difference = difference%60;

    dateFormamted += " $minutes minutos";
  }

  if(difference > 0){

    dateFormamted += " ${difference}s";
  }

  return dateFormamted;
}