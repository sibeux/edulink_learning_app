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

String formatPrice(double price) {
  if (price == 0) {
    return 'No Price Set';
  }
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  return formatter.format(price);
}

String formatChatDate(String dateString) {
  final date = DateTime.parse(dateString);
  final now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    // Jika hari ini, tampilkan jam:menit
    return DateFormat.Hm().format(date);
  } else {
    // Jika beda hari, tampilkan tanggal (misal: 13 Jun 2025)
    return DateFormat('dd MMM yyyy').format(date);
  }
}
