import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/time_filter_dropdown.dart';

class LogRecordsScreen extends StatefulWidget {
  const LogRecordsScreen({super.key});

  @override
  State<LogRecordsScreen> createState() => _LogRecordsScreenState();
}

class _LogRecordsScreenState extends State<LogRecordsScreen> {
  String _selectedRange = 'Today';
  // mutable records stored in state for editing/deleting in frontend
  late List<Map<String, String>> _records;

  @override
  void initState() {
    super.initState();
    _records = [
      {
        'date': '01/07/25',
        'time': '9:26pm',
        'glucose': '120 mg/dl',
        'status': 'Normal',
        'note': 'felt dizzyyyyyyyyyyyyyyyyyyyy',
        'readingType': 'Random',
        'source': 'Scan'
      },
      {
        'date': '01/07/25',
        'time': '8:10am',
        'glucose': '95 mg/dl',
        'status': 'Normal',
        'note': 'all good',
        'readingType': 'Before Meal',
        'source': 'Manual'
      },
      {
        'date': '01/06/25',
        'time': '7:50pm',
        'glucose': '200 mg/dl',
        'status': 'High',
        'note': 'after dinner',
        'readingType': 'After Meal',
        'source': 'Scan'
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final records = _records;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Records'),
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textGray,
        elevation: 1,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonCyan,
                    shape: const StadiumBorder(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  ),
                  child: Text('Export Logs', style: AppTextStyles.button()),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.containerBackground,
                  border: Border.all(color: AppColors.borderGray.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header row
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Log Records', style: AppTextStyles.headline(color: AppColors.textBlack)),
                          // Time filter dropdown (reusable)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 150,
                              child: TimeFilterDropdown(
                                value: _selectedRange,
                                items: const [
                                  'Today',
                                  'This Week',
                                  'This Month',
                                  'This Year',
                                  'All Time',
                                  'Custom Range'
                                ],
                                onChanged: (v) => setState(() {
                                  _selectedRange = v ?? _selectedRange;
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Table header
                    Container(
                      color: AppColors.lightCyan,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                            Expanded(flex: 2, child: Text('Date', style: AppTextStyles.subtitle(color: AppColors.textBlack.withOpacity(0.9)))),
                            Expanded(flex: 2, child: Text('Time', style: AppTextStyles.subtitle(color: AppColors.textBlack.withOpacity(0.9)))),
                            Expanded(flex: 3, child: Text('Blood Sugar', style: AppTextStyles.subtitle(color: AppColors.textBlack.withOpacity(0.9)))),
                            Expanded(flex: 2, child: Text('Status', style: AppTextStyles.subtitle(color: AppColors.textBlack.withOpacity(0.9)))),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),

                    // List of records
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: records.length,
                      separatorBuilder: (_, __) => const Divider(height: 0),
                      itemBuilder: (context, index) {
                        final r = records[index];
                        return Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            collapsedBackgroundColor: Colors.transparent,
                                title: Row(
                              children: [
                                Expanded(flex: 2, child: Text(r['date'] ?? '', style: AppTextStyles.body(color: AppColors.textGray))),
                                Expanded(flex: 2, child: Text(r['time'] ?? '', style: AppTextStyles.body(color: AppColors.textGray))),
                                Expanded(flex: 3, child: Text(r['glucose'] ?? '', style: AppTextStyles.body(color: AppColors.textGray))),
                                Expanded(flex: 2, child: Text(r['status'] ?? '', style: AppTextStyles.body(color: AppColors.textGray))),
                              ],
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                /*decoration: BoxDecoration(
                                  color: AppColors.borderGray,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(18),
                                    bottomRight: Radius.circular(18),
                                  ),
                                ),
                                padding: const EdgeInsets.all(12),*/
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Wrap(
                                      runSpacing: 8,
                                      spacing: 12,
                                      children: [
                                        /*_detailPair('Date:', r['date'] ?? ''),
                                        _detailPair('Time:', r['time'] ?? ''),
                                        _detailPair('Blood Sugar:', r['glucose'] ?? ''),
                                        _detailPair('Status:', r['status'] ?? ''),*/
                                        _detailPair('Note:', r['note'] ?? ''),
                                        _detailPair('Reading Type:', r['readingType'] ?? ''),
                                        _detailPair('Entry Source:', r['source'] ?? ''),
                                      ],
                                    ),
                                    
                                    const SizedBox(height: 12),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => _editRecord(index),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.buttonCyan,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                            textStyle: AppTextStyles.body(),
                                          ),
                                          child: const Text('Edit'),
                                        ),
                                        const SizedBox(width: 12),
                                        ElevatedButton(
                                          onPressed: () => _confirmDelete(index),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.bloodRed,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                            textStyle: AppTextStyles.body(),
                                          ),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailPair(String label, String value, {TextStyle? labelStyle, TextStyle? valueStyle}) {
    final lblStyle = labelStyle ?? AppTextStyles.subtitle(color: AppColors.textBlack);
    final valStyle = valueStyle ?? AppTextStyles.body(color: AppColors.textBlack);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: lblStyle),
        const SizedBox(width: 6),
        SizedBox(
          width: 180,
          child: Text(value, style: valStyle),
        ),
      ],
    );
  }

  Future<void> _editRecord(int index) async {
    final record = _records[index];
    final noteController = TextEditingController(text: record['note'] ?? '');
    String readingType = record['readingType'] ?? 'Random';

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Entry'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: readingType,
              style: AppTextStyles.body(),
              items: [
                DropdownMenuItem(value: 'Random', child: Text('Random', style: AppTextStyles.body())),
                DropdownMenuItem(value: 'Before Meal', child: Text('Before Meal', style: AppTextStyles.body())),
                DropdownMenuItem(value: 'After Meal', child: Text('After Meal', style: AppTextStyles.body())),
              ],
              onChanged: (v) => readingType = v ?? readingType,
              decoration: const InputDecoration(labelText: 'Reading Type'),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              decoration: InputDecoration(labelText: 'Entry Source', hintText: record['source'] ?? ''),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // save to local state
              setState(() {
                _records[index] = {
                  ..._records[index],
                  'note': noteController.text,
                  'readingType': readingType,
                };
              });
              Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    // dispose controller
    noteController.dispose();
    return;
  }

  Future<void> _confirmDelete(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.bloodRed),
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        _records.removeAt(index);
      });
    }
  }
}
