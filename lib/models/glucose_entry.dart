class GlucoseEntry {
  String? id;
  DateTime dateTime;
  double glucoseValue;
  String status;
  String note;
  String readingType;
  String source;
  String? imagePath;

  GlucoseEntry({
    this.id,
    required this.dateTime,
    required this.glucoseValue,
    required this.status,
    required this.note,
    required this.readingType,
    required this.source,
    this.imagePath,
  });
}
