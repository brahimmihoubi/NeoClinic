import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/medicalrecordscontroller.dart';
import 'package:neoclinic/models/medicalrecords_model.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/views/recordsdetails_screen.dart';

class MedicalRecordsScreen extends StatefulWidget {
  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  final controller = Get.put(MedicalRecordsController());
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Lab Results', 'Prescriptions', 'Imaging', 'Cardiology'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Health Records & Lab Vault', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar(
                'HIPAA Vault Export',
                'Generating signed 256-bit encrypted medical summary PDF...',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
              );
            },
            icon: const Icon(Icons.picture_as_pdf_outlined, color: AppColors.primary),
            tooltip: 'Download HIPAA PDF',
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.uploadrecords),
            icon: const Icon(Icons.cloud_upload_outlined, color: AppColors.primary),
            tooltip: 'Upload Document',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CLIA Certification Badge (SCREEN_23 spec)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.secondaryContainer, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.verified_user_rounded, color: AppColors.secondary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CLIA Accredited Diagnostic Vault', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
                        Text('Certificate #45D2189412 • HIPAA Certified 256-bit Encrypted', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 2. Biomarker Telemetry Trends Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Recent Biomarker Trends',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(8)),
                        child: const Text('Dr. Smith Attending', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _biomarkerRow('LDL Cholesterol', '142 mg/dL', 'Target: < 100 mg/dL', 'Elevated', AppColors.warning, AppColors.warningContainer),
                  const Divider(height: 20, color: AppColors.border),
                  _biomarkerRow('Fasting Blood Glucose', '98 mg/dL', 'Target: 70–99 mg/dL', 'Normal', AppColors.success, AppColors.successContainer),
                  const Divider(height: 20, color: AppColors.border),
                  _biomarkerRow('Hemoglobin A1c', '5.4%', 'Target: < 5.7%', 'Optimal', AppColors.secondary, AppColors.secondaryContainer),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Search Bar
            TextField(
              onChanged: (v) => controller.setSearchQuery(v),
              decoration: InputDecoration(
                hintText: 'Search diagnostic reports, labs, prescriptions...',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.border)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
              ),
            ),

            const SizedBox(height: 16),

            // 4. Category Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
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
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // 5. Records List
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator(color: AppColors.primary)));
              }

              final records = controller.filteredRecords;
              if (records.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        const Icon(Icons.folder_open_rounded, size: 48, color: AppColors.textSecondary),
                        const SizedBox(height: 12),
                        Text('No records found in this vault view.', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return _recordItem(record);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _biomarkerRow(String name, String value, String target, String badge, Color badgeColor, Color badgeBg) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(target, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(8)),
              child: Text(badge, style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _recordItem(MedicalRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: record.type.contains('Prescription') ? AppColors.secondaryContainer : AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            record.type.contains('Prescription') ? Icons.medication_outlined : Icons.description_outlined,
            color: record.type.contains('Prescription') ? AppColors.secondary : AppColors.primary,
            size: 22,
          ),
        ),
        title: Text(record.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${record.type} • Dr. John Smith, MD', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 2),
            Text(
              '${record.date.year}-${record.date.month.toString().padLeft(2, '0')}-${record.date.day.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
        onTap: () => Get.to(() => RecordDetailScreen(record: record)),
      ),
    );
  }
}
