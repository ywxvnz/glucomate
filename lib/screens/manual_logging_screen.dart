import 'package:flutter/material.dart';
import '../repositories/glucose_repository.dart';
import '../models/glucose_entry.dart';
import '../utils/app_colors.dart';

class ManualLoggingScreen extends StatefulWidget {
  const ManualLoggingScreen({super.key});

  @override
  State<ManualLoggingScreen> createState() => _ManualLoggingScreenState();
}

class _ManualLoggingScreenState extends State<ManualLoggingScreen> {
  final GlucoseRepository repository = GlucoseRepository();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController(
    text: '100',
  );
  final TextEditingController statusController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String readingType = 'Random';

  @override
  void initState() {
    super.initState();
    _updateStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Logging'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textGray,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.containerBackground,
            border: Border.all(color: AppColors.borderGray),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // DATE
                TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: _pickDate,
                ),
                const SizedBox(height: 12),

                // TIME
                TextField(
                  controller: timeController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Time',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  onTap: _pickTime,
                ),
                const SizedBox(height: 12),

                // BLOOD SUGAR WITH STEPPER
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: glucoseController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Blood Sugar (mg/dL)',
                        ),
                        onChanged: (_) => _updateStatus(),
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_drop_up),
                          onPressed: () => _changeGlucose(1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: () => _changeGlucose(-1),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // STATUS (AUTO)
                TextField(
                  controller: statusController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
                const SizedBox(height: 12),

                // NOTE
                TextField(
                  controller: noteController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Note'),
                ),
                const SizedBox(height: 12),

                // READING TYPE DROPDOWN
                DropdownButtonFormField<String>(
                  initialValue: readingType,
                  decoration: const InputDecoration(labelText: 'Reading Type'),
                  items: const [
                    DropdownMenuItem(value: 'Random', child: Text('Random')),
                    DropdownMenuItem(
                      value: 'Before Meal',
                      child: Text('Before Meal'),
                    ),
                    DropdownMenuItem(
                      value: 'After Meal',
                      child: Text('After Meal'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => readingType = value!);
                  },
                ),
                const SizedBox(height: 24),

                // SAVE
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonCyan,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- LOGIC ----------------

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dateController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timeController.text =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    }
  }

  void _changeGlucose(int delta) {
    int value = int.tryParse(glucoseController.text) ?? 0;
    value = (value + delta).clamp(0, 600);
    glucoseController.text = value.toString();
    _updateStatus();
  }

  void _updateStatus() {
    final value = int.tryParse(glucoseController.text) ?? 0;

    if (value < 70) {
      statusController.text = 'Low';
    } else if (value <= 180) {
      statusController.text = 'Normal';
    } else {
      statusController.text = 'High';
    }
  }

  void _saveEntry() {
    final entry = GlucoseEntry(
      dateTime: DateTime.parse('${dateController.text} ${timeController.text}'),
      glucoseValue: double.parse(glucoseController.text),
      status: statusController.text,
      note: noteController.text,
      readingType: readingType,
      source: 'manual', // hidden backend logic
      imagePath: null,
    );

    repository.addEntry(entry);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reading saved locally')));
  }
}
