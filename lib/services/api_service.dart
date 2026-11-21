class ApiService {
  Future<List<String>> fetchUpcomingAppointments() async {
    await Future.delayed(Duration(seconds: 1));
    return ['Consult Dr. A — May 10', 'Consult Dr. B — May 15'];
  }
  // Similarly implement medical records, messages, etc.
}
