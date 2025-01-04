import 'package:hairvibe/Models/notice_repo.dart';
import 'package:hairvibe/Utility.dart';

import '../Models/appointment_model.dart';
import '../Models/notice_model.dart';

class NotificationFacade {
  final NoticeRepository _noticeRepo = NoticeRepository();

  Future<NoticeModel> createNotification({required String receiverID, required String content}) async {
    NoticeRepository repo = NoticeRepository();
    String id = await repo.generateNoticeID();
    return NoticeModel(
        noticeID: id,
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
      NoticeModel notification = await createNotification(receiverID: appointment.barberID!, content: content);
      _noticeRepo.addNoticeToFirestore(notification);
    }

    if (sendToCustomer) {
      NoticeModel notification = await createNotification(receiverID: appointment.customerID!, content: content);
      _noticeRepo.addNoticeToFirestore(notification);
    }
  }
}