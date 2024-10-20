import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formattedDate(Timestamp time) {
  DateTime dateTime = time.toDate();

  return DateFormat("d'th' MMMM, yyyy 'at' h:mm a").format(dateTime);
}
