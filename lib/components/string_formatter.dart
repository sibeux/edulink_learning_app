import 'package:intl/intl.dart';

String formatTimeHhMm(String? time) {
  if (time == null || time.isEmpty) return '';
  try {
    final parsed = DateFormat(
      'HH:mm',
    ).parse(time.length > 5 ? time.substring(0, 5) : time);
    return DateFormat('HH:mm').format(parsed);
  } catch (_) {
    return time;
  }
}
