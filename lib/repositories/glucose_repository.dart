import '../models/glucose_entry.dart';

class GlucoseRepository {
  // For now, we can store locally in memory
  final List<GlucoseEntry> _entries = [];

  List<GlucoseEntry> getAllEntries() => _entries;

  void addEntry(GlucoseEntry entry) {
    _entries.add(entry);
    // TODO: save to Hive or Firebase later
  }

  void updateEntry(int index, GlucoseEntry entry) {
    _entries[index] = entry;
    // TODO: update in Hive or Firebase
  }

  void deleteEntry(int index) {
    _entries.removeAt(index);
    // TODO: delete in Hive or Firebase
  }
}
