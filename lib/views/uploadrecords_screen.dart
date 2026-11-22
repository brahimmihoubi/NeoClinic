import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/medicalrecordscontroller.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';

class UploadRecordScreen extends StatefulWidget {
  @override
  State<UploadRecordScreen> createState() => _UploadRecordScreenState();
}

class _UploadRecordScreenState extends State<UploadRecordScreen> {
  final controller = Get.find<MedicalRecordsController>();

  String _selectedCategory = 'Lab Results';
  final TextEditingController _titleController = TextEditingController(text: 'Complete Blood Count & Lipid Panel');
  final TextEditingController _notesController = TextEditingController(text: 'Routine annual fasting panel requested by Dr. John Smith.');
  bool _isScanning = false;

  final List<String> _categories = ['Lab Results', 'Imaging / X-Ray', 'Prescription', 'Cardiology Report'];

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _simulateScan() {
    setState(() => _isScanning = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _isScanning = false;
        _titleController.text = 'Lipid Profile & Glucose Spectrometry';
        _notesController.text = 'AI OCR Extracted: LDL 142 mg/dL (Elevated), Fasting Glucose 98 mg/dL (Normal). Lab: BioMed Labs.';
      });
      Get.snackbar(
        'AI OCR Complete',
        'Biomarkers parsed with 99.4% confidence score',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.secondary,
        colorText: Colors.white,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Document Upload & AI Scanner', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Camera OCR Viewport (SCREEN_15 spec)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Viewport Grid Lines & Corners
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white38, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isScanning ? Icons.document_scanner : Icons.camera_alt_outlined,
                              color: _isScanning ? AppColors.secondary : Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isScanning ? 'AI Extracting Clinical Data...' : 'Align document inside viewfinder',
                              style: TextStyle(color: _isScanning ? AppColors.secondary : Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    child: ElevatedButton.icon(
                      onPressed: _isScanning ? null : _simulateScan,
                      icon: const Icon(Icons.auto_awesome, size: 16),
                      label: const Text('Capture & Run OCR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. Category Selector Chips
            const Text('Document Classification:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = cat);
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // 3. Document Title
            const Text('Document Title', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
              ),
            ),

            const SizedBox(height: 16),

            // 4. Clinical Content & Extracted Parameters
            const Text('Clinical Notes / AI Parsed Content', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
              ),
            ),

            const SizedBox(height: 28),

            // 5. Submit CTA
            ElevatedButton.icon(
              onPressed: () {
                final record = MedicalRecord(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _titleController.text.trim(),
                  type: _selectedCategory,
                  content: _notesController.text.trim(),
                  date: DateTime.now(),
                );
                controller.addRecord(record);
                Get.back();
                Get.snackbar(
                  'Encrypted to Vault',
                  'Document synchronized to patient HIPAA vault',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.success,
                  colorText: Colors.white,
                  icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
                );
              },
              icon: const Icon(Icons.cloud_upload_rounded),
              label: const Text('Encrypt & Transmit to Vault', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
