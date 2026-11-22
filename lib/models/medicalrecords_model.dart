class MedicalRecord {
  final String id;
  final String title;
  final DateTime date;
  final String type;
  final String content;
  final String? prescription;
  final String? symptoms;

  MedicalRecord({
    this.id = '',
    required this.title,
    required this.date,
    required this.type,
    required this.content,
    this.prescription,
    this.symptoms,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    final parsedDate = DateTime.tryParse(json['created_at']?.toString() ?? '') ??
        DateTime.tryParse(json['date']?.toString() ?? '') ??
        DateTime.now();

    final diagnosis = json['diagnosis']?.toString() ?? json['title']?.toString() ?? 'Medical Record';
    final prescription = json['prescription']?.toString() ?? '';
    final symptoms = json['symptoms']?.toString() ?? '';
    final notes = json['notes']?.toString() ?? json['content']?.toString() ?? '';
    final type = json['type']?.toString() ?? (prescription.isNotEmpty ? 'Prescription' : 'Consultation');

    String combinedContent = notes;
    if (prescription.isNotEmpty) {
      combinedContent = combinedContent.isEmpty ? 'Prescription: $prescription' : '$combinedContent\nPrescription: $prescription';
    }
    if (symptoms.isNotEmpty) {
      combinedContent = combinedContent.isEmpty ? 'Symptoms: $symptoms' : 'Symptoms: $symptoms\n$combinedContent';
    }

    return MedicalRecord(
      id: json['id']?.toString() ?? '',
      title: diagnosis,
      date: parsedDate,
      type: type,
      content: combinedContent.isEmpty ? 'No notes available' : combinedContent,
      prescription: prescription,
      symptoms: symptoms,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date.toIso8601String(),
    'type': type,
    'content': content,
  };
}
