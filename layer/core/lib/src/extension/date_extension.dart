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

  /// Format with full date and time "EEEE, MMMM d, yyyy H:m"
  String get toFullDateWithoutTime {
    return DateFormat('EEEE, MMMM d, yyyy').format(this);
  }

  /// Format with method "MMMM"
  String get toMonthAndYear {
    return DateFormat('MMMM, yyyy').format(this);
  }
}

extension StringDateFormatting on String {
  /// Format as "yyyy-MM-dd"
  DateTime get toFormattedDate {
    return DateFormat('yyyy-MM-dd').parse(this);
  }

  /// Format as "dd MMM yyyy, hh:mm a"
  DateTime get toFormattedDateTime {
    return DateFormat('dd MMM yyyy, hh:mm a').parse(this);
  }

  /// Format with full date and time "EEEE, MMMM d, yyyy H:m"
  DateTime get toFullDateTime {
    return DateFormat('EEEE, MMMM d, yyyy H:m').parse(this);
  }
}
