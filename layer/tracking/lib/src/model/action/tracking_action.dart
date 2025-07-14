abstract class TrackingAction {
  const TrackingAction(this.action);

  final String? action;

  Map<String, dynamic> toJson();

  Map<String, Object> get parameters => toJson().map((key, value) {
    return MapEntry(key, value is String ? value : value.toString());
  });
}
