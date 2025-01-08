import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  /// Format as "yyyy-MM-dd"
  String get toFormattedDate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Format as "dd MMM yyyy, hh:mm a"
  String get toFormattedDateTime {
    return DateFormat('dd MMM yyyy, hh:mm a').format(this);
  }

  /// Format with full date and time "EEEE, MMMM d, yyyy H:m"
  String get toFullDateTime {
    return DateFormat('EEEE, MMMM d, yyyy H:m').format(this);
  }
}
