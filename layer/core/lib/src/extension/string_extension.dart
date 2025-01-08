extension StringMapper on String {
  String get capitalize {
    switch (length) {
      case 0:
        return this;
      case 1:
        return toUpperCase();
      default:
        return substring(0, 1).toUpperCase() + substring(1);
    }
  }

  bool get isBlank => trimLeft().isEmpty;

  bool get isNotBlank => !isBlank;
}

extension NullableStringIsNullOrEmptyExtension on String? {
  bool get isNull => this == null;

  bool get isNonNull => this != null;

  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNullOrBlank => this?.isBlank ?? true;

  bool get isNotNullOrBlank => !isNullOrBlank;

  String orEmpty() => this ?? '';
}

extension StringsExtension on List<String> {
  String get longestString {
    String longestText = '';
    int maxLength = 0;

    for (final text in this) {
      if (text.length > maxLength) {
        maxLength = text.length;
        longestText = text;
      }
    }

    return longestText;
  }
}
