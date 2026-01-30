import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/time_filter_dropdown.dart';

class LogRecordsScreen extends StatefulWidget {
  const LogRecordsScreen({super.key});

  @override
  State<LogRecordsScreen> createState() => _LogRecordsScreenState();
}

class _LogRecordsScreenState extends State<LogRecordsScreen> {
  String _selectedRange = 'Today';

  // Sample data for preview/demo
  List<Map<String, String>> get _sampleRecords => [
        {
          'date': '01/07/25',
          'time': '9:26pm',
          'glucose': '120 mg/dl',
          'status': 'Normal',
          'note': 'felt dizzyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy',
          'readingType': 'random',
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

  @override
  Widget build(BuildContext context) {
    final records = _sampleRecords;
    
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
                  child: const Text(
                    'Export Logs',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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
                          Text(
                            'Log Records',
                            style: TextStyle(
                              color: AppColors.textBlack,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                          Expanded(
                              flex: 2,
                              child: Text('Date',
                                  style: TextStyle(
                                      color: AppColors.textBlack.withOpacity(0.9),
                                      fontWeight: FontWeight.w600))),
                          Expanded(
                              flex: 2,
                              child: Text('Time',
                                  style: TextStyle(
                                      color: AppColors.textBlack.withOpacity(0.9),
                                      fontWeight: FontWeight.w600))),
                          Expanded(
                              flex: 3,
                              child: Text('Blood Sugar',
                                  style: TextStyle(
                                      color: AppColors.textBlack.withOpacity(0.9),
                                      fontWeight: FontWeight.w600))),
                          Expanded(
                              flex: 2,
                              child: Text('Status',
                                  style: TextStyle(
                                      color: AppColors.textBlack.withOpacity(0.9),
                                      fontWeight: FontWeight.w600))),
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
                                Expanded(flex: 2, child: Text(r['date'] ?? '', style: TextStyle(color: AppColors.textGray))),
                                Expanded(flex: 2, child: Text(r['time'] ?? '', style: TextStyle(color: AppColors.textGray))),
                                Expanded(flex: 3, child: Text(r['glucose'] ?? '', style: TextStyle(color: AppColors.textGray))),
                                Expanded(flex: 2, child: Text(r['status'] ?? '', style: TextStyle(color: AppColors.textGray))),
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
                                        // Edit
                                        Material(
                                          color: AppColors.buttonCyan,
                                          shape: const CircleBorder(),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: AppColors.iconBlack,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        // Delete
                                        Material(
                                          color: AppColors.bloodRed,
                                          shape: const CircleBorder(),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.delete,
                                              color: AppColors.iconBlack,
                                            ),
                                          ),
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

  Widget _detailPair(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 180,
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.textBlack,
            ),
          ),
        ),
      ],
    );
  }
}
 