import 'package:hairvibe/Contract/schedule_list_screen_contract.dart';

import 'detail_barber_presenter.dart';

class ScheduleListScreenPresenter {
  final ScheduleListScreenContract _view;
  final DetailBarberPresenter _parentPresenter;
  ScheduleListScreenPresenter(this._view, this._parentPresenter);

  List<bool> initToggles = [];

  Future<void> handleSave(List<Map<String, dynamic>> workSessions) async {
    List<bool> workSessionToggles = [];
    for (Map<String, dynamic> workSession in workSessions) {
      workSessionToggles.add(workSession['enabled']);
    }

    // compare toggle
    bool noChange = true;
    for (int i = 0; i < 7; i++) {
      if (initToggles[i] != workSessionToggles[i]) {
        noChange = false;
        break;
      }
    }

    if (noChange) {
      return;
    }

    _view.onWaitingProgressBar();
    await _parentPresenter.updateWorkSessions(workSessionToggles);
    initToggles = workSessionToggles;
    _view.onPopContext();
    _view.onSaveSucceeded();
  }
}