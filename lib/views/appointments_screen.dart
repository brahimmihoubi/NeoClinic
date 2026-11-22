import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neoclinic/constants/app_colors.dart';
import 'package:neoclinic/controllers/appointment_controller.dart';
import 'package:neoclinic/routes/app_routes.dart';
import 'package:neoclinic/views/appointmentsdetails_screen.dart';
import 'package:neoclinic/widgets/appointment_card.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> with SingleTickerProviderStateMixin {
  final controller = Get.put(AppointmentController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Specialist & Booking Hub', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past Visits'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }

        return TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Upcoming
            _buildList(
              controller.upcomingAppointments,
              emptyMsg: 'No upcoming consultations scheduled.',
              showBookButton: true,
            ),
            // Tab 2: Past
            _buildList(
              controller.pastAppointments,
              emptyMsg: 'No past consultations on record.',
              showBookButton: false,
            ),
            // Tab 3: Cancelled
            _buildList(
              [],
              emptyMsg: 'No cancelled appointments.',
              showBookButton: false,
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.appointmentsbooking),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Book Specialist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildList(List appointments, {required String emptyMsg, required bool showBookButton}) {
    if (appointments.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
                child: const Icon(Icons.calendar_month_outlined, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              Text(emptyMsg, textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 15)),
              if (showBookButton) ...[
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.appointmentsbooking),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Schedule Consultation'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => controller.fetchAppointments(),
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCard(
            appointment: appointment,
            onTap: () => Get.to(() => AppointmentDetailScreen(appointment: appointment)),
          );
        },
      ),
    );
  }
}
