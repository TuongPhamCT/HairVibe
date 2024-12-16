import 'package:hairvibe/Contract/detail_barber_contract.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';

class DetailBarberPresenter {
  final DetailBarberContract _view;
  DetailBarberPresenter(this._view);

  final BarberSingleton _singleton = BarberSingleton.getInstance();

  Future<void> getData() async {
    _view.onLoadDataSucceed();
  }

  String getBarberAvatarUrl() {
    return _singleton.barber!.image!;
  }

  String getBarberName() {
    return _singleton.barber!.name!;
  }
}