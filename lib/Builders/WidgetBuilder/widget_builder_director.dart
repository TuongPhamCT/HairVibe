import 'package:hairvibe/Builders/WidgetBuilder/barber_list_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/book_barber_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/cancelled_appoint_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/check_service_list_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/completed_appoint_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/review_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/service_list_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/upcoming_appoint_item_builder.dart';
import 'package:hairvibe/Builders/WidgetBuilder/voucher_item_builder.dart';
import 'package:hairvibe/Commands/AppointmentTabs/appoint_tab_cancel_command.dart';
import 'package:hairvibe/Commands/AppointmentTabs/appoint_tab_rebook_command.dart';
import 'package:hairvibe/Commands/AppointmentTabs/appoint_tab_view_command.dart';
import 'package:hairvibe/Commands/all_barbers/all_barbers_book_barber_command.dart';
import 'package:hairvibe/Commands/all_barbers/all_barbers_press_barber_command.dart';
import 'package:hairvibe/Commands/home_screen/home_screen_press_barber_command.dart';
import 'package:hairvibe/Commands/main_booking/main_booking_select_barber_command.dart';
import 'package:hairvibe/Commands/voucher_redeem/voucher_redeem_on_pressed_command.dart';
import 'package:hairvibe/Models/coupon_model.dart';
import 'package:hairvibe/Models/work_session_model.dart';
import 'package:hairvibe/Presenter/appointment_tab_presenter.dart';
import 'package:hairvibe/Presenter/barber_screen_presenter.dart';
import 'package:hairvibe/Presenter/home_screen_presenter.dart';
import 'package:hairvibe/Presenter/main_booking_presenter.dart';
import 'package:hairvibe/Presenter/voucher_page_presenter.dart';
import 'package:hairvibe/Presenter/voucher_redeem_presenter.dart';
import 'package:hairvibe/commands/command_interface.dart';

import '../../Commands/voucher_page/voucher_page_on_pressed_command.dart';
import '../../Models/appointment_model.dart';
import '../../Models/rating_model.dart';
import '../../Models/service_model.dart';
import '../../Models/user_model.dart';
import '../../Utility.dart';
import 'barber_item_detail_builder.dart';

class CustomizedWidgetBuilderDirector {

  // TODO: Home page

  void makePressableServiceItem({
    required ServiceListItemBuilder builder,
    required ServiceModel model,
    required CommandInterface? onPressed,
  }) {
    builder.reset();
    builder.setService(model);
    builder.setOnPressed(onPressed);
  }

  void makeBarberListItem({
    required BarberListItemBuilder builder,
    required UserModel barber,
    required HomeScreenPresenter presenter,
  }) {
    builder.reset();
    builder.setBarber(barber);
    builder.setDescription("Barber");
    builder.setRating(presenter.ratings[barber.userID] != null ? presenter.ratings[barber.userID]!.toStringAsFixed(1) : "0");
    builder.setOnPressed(HomeScreenPressBarberCommand(
      presenter: presenter,
      barber: barber
    ));
  }

  // TODO: Admin comment page

  void makeAdminCommentServiceItem({
    required ServiceListItemBuilder builder,
    required ServiceModel model,
    required CommandInterface? onDelete,
  }) {
    builder.reset();
    builder.setService(model);
    builder.setDeletable(true);
    builder.setOnDelete(onDelete);
  }

  // TODO: All barbers page
  void makeAllBarbersDetailBarberItem({
    required BarberItemDetailBuilder builder,
    required UserModel barber,
    required BarberScreenPresenter presenter,
  }) {
    builder.reset();
    builder.setBarber(barber);
    builder.setDescription("Barber");
    builder.setRating(Utility.formatRatingValue(presenter.ratings[barber.userID]));

    List<int> workSessionsInt = [];
    for (WorkSessionModel session in presenter.workSessions[barber.userID]!) {
      workSessionsInt.add(session.day!);
    }
    builder.setWorkSessions(workSessionsInt);

    builder.setOnDetailPressed(AllBarbersPressBarberCommand(
      presenter: presenter,
      barberModel: barber,
    ));

    builder.setOnBookPressed(AllBarbersBookBarberCommand(
      presenter: presenter,
      barberModel: barber,
    ));
  }

  // TODO: appointment tab
  void makeCancelledAppointItem({
    required CancelledAppointItemBuilder builder,
    required AppointmentModel appointment,
    required AppointmentTabPresenter presenter,
  }) {
    builder.reset();
    builder.setAppointment(appointment);
    builder.setBarber(presenter.findBarberByID(appointment.barberID!)!);
    builder.setOnRebookPressed(AppointTabRebookCommand(
        presenter: presenter,
        appointment: appointment
    ));
  }

  void makeCompletedAppointItem({
    required CompletedAppointItemBuilder builder,
    required AppointmentModel appointment,
    required AppointmentTabPresenter presenter,
  }) {
    builder.reset();
    builder.setAppointment(appointment);
    builder.setBarber(presenter.findBarberByID(appointment.barberID!)!);
    builder.setOnViewReceiptPressed(AppointTabViewCommand(
        presenter: presenter,
        appointment: appointment
    ));
  }

  void makeUpcomingAppointItem({
    required UpcomingAppointItemBuilder builder,
    required AppointmentModel appointment,
    required AppointmentTabPresenter presenter,
  }) {
    builder.reset();
    builder.setAppointment(appointment);
    builder.setBarber(presenter.findBarberByID(appointment.barberID!)!);
    builder.setOnViewReceiptPressed(AppointTabViewCommand(
        presenter: presenter,
        appointment: appointment
    ));
    builder.setOnCancelPressed(AppointTabCancelCommand(
        presenter: presenter,
        appointment: appointment
    ));
  }

  // TODO: main booking
  void makeBookBarberItem({
    required BookBarberItemBuilder builder,
    required UserModel barber,
    required int index,
    required MainBookingPresenter presenter,
  }) {
    builder.reset();
    builder.setBarber(barber);
    builder.setRating(Utility.formatRatingValue(presenter.ratings[barber.userID]));
    builder.setIsSelected(barber.userID == presenter.selectedBarber!.userID);
    builder.setOnTap(MainBookingSelectBarberCommand(
        presenter: presenter,
        barber: barber,
        index: index
    ));
  }

  void makeCheckServiceListItem({
    required CheckServiceListItemBuilder builder,
    required ServiceModel service,
    required int index,
    required MainBookingPresenter presenter,
  }) {
    builder.reset();
    builder.setService(service);
    builder.setIsChecked(presenter.services[index]['isChecked']);
    builder.setOnChanged(
        (bool newValue) {
          presenter.handleSelectService(service, index, newValue);
          presenter.services[index]['isChecked'] = newValue;
        }
    );
  }

  // TODO: voucher redeem & voucher page
  void makeVoucherItem({
    required VoucherItemBuilder builder,
    required CouponModel model,
    required dynamic presenter,
  }) {
    if (presenter is VoucherRedeemPresenter
      || presenter is VoucherPagePresenter) {
      builder.reset();
      builder.setCouponModel(model);

      if (presenter is VoucherRedeemPresenter) {
        builder.setOnPressed(VoucherRedeemOnPressedCommand(
            presenter: presenter,
            model: model
        ));
      } else {
        builder.setOnPressed(VoucherPageOnPressedCommand(
            presenter: presenter,
            model: model
        ));
      }
    }
  }

  // TODO: other

  void makeReviewItem({
    required ReviewItemBuilder builder,
    required UserModel user,
    required RatingModel rating
  }) {
    builder.reset();
    builder.setRatingModel(rating);
    builder.setUserModel(user);
  }
}