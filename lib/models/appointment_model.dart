class AppointmentModel {
  final String id;
  final String doctorName;
  final DateTime dateTime;
  final String notes;
  final bool isUpcoming;

  AppointmentModel({
    required this.id,
    required this.doctorName,
    required this.dateTime,
    required this.notes,
    required this.isUpcoming,
  });
}
