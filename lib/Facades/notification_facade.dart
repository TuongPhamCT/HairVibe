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
    required bool sendToCustomer
  }) async {
    String content = "Your appointment at ${Utility.formatStringFromDateTime(appointment.date)} was cancel";
    if (sendToBarber) {
      NoticeModel notification = createNotification(receiverID: appointment.barberID!, content: content);
      await _noticeRepo.addNoticeToFirestore(notification);
    }

    if (sendToCustomer) {
      NoticeModel notification = createNotification(receiverID: appointment.customerID!, content: content);
      await _noticeRepo.addNoticeToFirestore(notification);
    }
  }
}