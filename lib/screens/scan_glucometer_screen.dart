import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'manual_logging_screen.dart';
import 'package:flutter/material.dart';
import 'app_shell.dart';

class ScanGlucometerScreen extends StatefulWidget {
  const ScanGlucometerScreen({super.key});

  @override
  State<ScanGlucometerScreen> createState() => _ScanGlucometerScreenState();
}

class _ScanGlucometerScreenState extends State<ScanGlucometerScreen> {
  // Mock extracted data (in real app this would come from OCR)
  Map<String, String> _extracted = {
    'date': '01/07/25',
    'time': '9:26pm',
    'bloodSugar': '120 mg/dl',
    'status': 'Normal',
    'note': 'felt dizzyyyyyyyyyyyyyyyyyyyy',
    'readingType': 'Random',
    'source': 'Scan',
  };

  void _onManualInput() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AppShell(initialIndex: 5)),
    );
  }

  Future<void> _onScanPressed() async {
    // Simulate scanning then show the result screen/dialog
    await showDialog(
      context: context,
      builder: (_) => _ScannedResultDialog(
        extracted: Map.from(_extracted),
        onSave: (updated) {
          setState(() {
            _extracted = updated;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Scanned entry saved')),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Glucometer'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textGray,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Camera Preview: 4:3 aspect ratio (larger)
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: AppColors.borderGray),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    size: 64,
                    color: AppColors.iconBlack,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Scan Button (prominent)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _onScanPressed,
                icon: const Icon(Icons.document_scanner),
                label: Text('Scan', style: AppTextStyles.button()),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColors.buttonCyan,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Manual Input Button (outlined, smaller)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _onManualInput,
                icon: const Icon(Icons.edit),
                label: Text('Manual Input', style: AppTextStyles.button(color: AppColors.cyan)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  foregroundColor: AppColors.cyan,
                  side: BorderSide(color: AppColors.cyan),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannedResultDialog extends StatefulWidget {
  final Map<String, String> extracted;
  final void Function(Map<String, String>) onSave;

  const _ScannedResultDialog({
    required this.extracted,
    required this.onSave,
  });

  @override
  State<_ScannedResultDialog> createState() => _ScannedResultDialogState();
}

class _ScannedResultDialogState extends State<_ScannedResultDialog> {
  late TextEditingController _noteController;
  late String _readingType;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.extracted['note'] ?? '');
    _readingType = widget.extracted['readingType'] ?? 'Random';
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a dialog with scroll content so it fits on smaller screens
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Extracted Data:', style: AppTextStyles.title(color: AppColors.textBlack)),
              const SizedBox(height: 12),

              // Scanned image preview area (placeholder)
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderGray),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 64,
                    color: AppColors.iconBlack,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Card-like area for fields
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderGray.withOpacity(0.6)),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top row: Date / Time
                    Row(
                      children: [
                        Expanded(
                          child: _readOnlyPair('Date', widget.extracted['date'] ?? ''),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _readOnlyPair('Time', widget.extracted['time'] ?? ''),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _readOnlyPair('Blood Sugar', widget.extracted['bloodSugar'] ?? ''),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _readOnlyPair('Status', widget.extracted['status'] ?? ''),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Note (editable)
                    Text('Note:', style: AppTextStyles.subtitle(color: AppColors.textBlack)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _noteController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Add a note',
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Reading Type (editable dropdown)
                    Text('Reading Type:', style: AppTextStyles.subtitle(color: AppColors.textBlack)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _readingType,
                      items: [
                        DropdownMenuItem(value: 'Random', child: Text('Random', style: AppTextStyles.body())),
                        DropdownMenuItem(value: 'Before Meal', child: Text('Before Meal', style: AppTextStyles.body())),
                        DropdownMenuItem(value: 'After Meal', child: Text('After Meal', style: AppTextStyles.body())),
                        DropdownMenuItem(value: 'Fasting', child: Text('Fasting', style: AppTextStyles.body())),
                      ],
                      onChanged: (v) => setState(() => _readingType = v ?? _readingType),
                      decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),

                    // Entry Source (read-only)
                    const SizedBox(height: 6),
                    _readOnlyPair('Entry Source', widget.extracted['source'] ?? ''),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Only update note and readingType as requested
                        final updated = Map<String, String>.from(widget.extracted);
                        updated['note'] = _noteController.text;
                        updated['readingType'] = _readingType;
                        widget.onSave(updated);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonCyan),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readOnlyPair(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption(color: AppColors.textGray)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.body(color: AppColors.textBlack)),
      ],
    );
  }
}