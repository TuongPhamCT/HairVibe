import 'package:hairvibe/Models/notice_repo.dart';
import 'package:hairvibe/Utility.dart';

import '../Models/appointment_model.dart';
import '../Models/notice_model.dart';

class NotificationFacade {
  final NoticeRepository _noticeRepo = NoticeRepository();

  NoticeModel createNotification({required String receiverID, required String content}) {
    return NoticeModel(
        receiverID: receiverID,
        date: DateTime.now(),
        content: content,
        isRead: false
    );
  }

  Future<void> createCancelAppointmentNotification({
    required AppointmentModel appointment,
    required bool sendToBarber,
    required bool sendToCustomer,
    String? reason,
  }) async {
    String content = "";
    if (reason != null) {
      content = "Your appointment at ${Utility.formatStringFromDateTime(appointment.date)} was cancel"
          " (Appointment ID: ${appointment.appointmentID})"
          " with reason: $reason";
    } else {
      content = "Your appointment at ${Utility.formatStringFromDateTime(appointment.date)} was cancel."
          " (Appointment ID: ${appointment.appointmentID})";
    }

    if (sendToBarber) {
      NoticeModel notification = createNotification(receiverID: appointment.barberID!, content: content);
      await _noticeRepo.addNoticeToFirestore(notification);
    }

    if (sendToCustomer) {
      NoticeModel notification = createNotification(receiverID: appointment.customerID!, content: content);
      await _noticeRepo.addNoticeToFirestore(notification);
    }
  }

  Future<void> createCompleteAppointmentNotification({
    required AppointmentModel appointment,
  }) async {
    String content = "Your appointment at ${Utility.formatStringFromDateTime(appointment.date)} was completed."
        " (Appointment ID: ${appointment.appointmentID})";
    NoticeModel notification = createNotification(receiverID: appointment.customerID!, content: content);
    await _noticeRepo.addNoticeToFirestore(notification);
  }

  Future<void> createBookingAppointmentNotification({
    required AppointmentModel appointment,
    required String customerName,
  }) async {
    String content = "$customerName has booked an appointment with you at ${Utility.formatStringFromDateTime(appointment.date)}."
        " (Appointment ID: ${appointment.appointmentID})";
    NoticeModel notification = createNotification(receiverID: appointment.barberID!, content: content);
    await _noticeRepo.addNoticeToFirestore(notification);
  }

  Future<void> createRatingBarberNotification({
    required double ratingValue,
    required String customerName,
    required String barberID
  }) async {
    String content = "$customerName has left a review for you with rating of $ratingValue stars.";
    NoticeModel notification = createNotification(receiverID: barberID, content: content);
    await _noticeRepo.addNoticeToFirestore(notification);
  }
}