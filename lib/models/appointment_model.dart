class AppointmentModel {
  final String id;
  final String doctorName;
  final DateTime dateTime;
  final String notes;
  final bool isUpcoming;
  final int? doctorId;
  final String? status;
  final String? type;

  AppointmentModel({
    required this.id,
    required this.doctorName,
    required this.dateTime,
    required this.notes,
    required this.isUpcoming,
    this.doctorId,
    this.status,
    this.type,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final parsedDate = DateTime.tryParse(json['appointment_date']?.toString() ?? '') ?? DateTime.now();
    final status = json['status']?.toString() ?? 'scheduled';
    final isUpcoming = status == 'scheduled' && parsedDate.isAfter(DateTime.now().subtract(const Duration(hours: 2)));

    String docName = 'Doctor';
    if (json['doctor_first_name'] != null || json['doctor_last_name'] != null) {
      docName = 'Dr. ${json['doctor_first_name'] ?? ''} ${json['doctor_last_name'] ?? ''}'.trim();
    } else if (json['doctor_id'] != null) {
      docName = 'Doctor #${json['doctor_id']}';
    }

    return AppointmentModel(
      id: json['id']?.toString() ?? '',
      doctorId: json['doctor_id'] != null ? int.tryParse(json['doctor_id'].toString()) : null,
      doctorName: docName,
      dateTime: parsedDate,
      notes: json['notes']?.toString() ?? '',
      isUpcoming: isUpcoming,
      status: status,
      type: json['type']?.toString() ?? 'consultation',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'doctor_id': doctorId,
    'appointment_date': dateTime.toIso8601String(),
    'notes': notes,
    'status': status ?? (isUpcoming ? 'scheduled' : 'completed'),
    'type': type ?? 'consultation',
  };
}
