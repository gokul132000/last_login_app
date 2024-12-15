class FormattedDateTime {
  static String formatDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return "Today, ${_formatTime(dateTime)}";
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      return "Yesterday, ${_formatTime(dateTime)}";
    }

    return "${_formatDate(dateTime)}, ${_formatTime(dateTime)}";
  }

  static String _formatTime(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour >= 12 ? "PM" : "AM";

    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    String formattedMinute = minute < 10 ? "0$minute" : "$minute";

    return "$hour:$formattedMinute $period";
  }

  static String _formatDate(DateTime dateTime) {
    return "${_getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}";
  }

  static String _getMonth(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}
