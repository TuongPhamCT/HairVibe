import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Contract/rating_barber_contract.dart';
import 'package:hairvibe/Presenter/rating_barber_presenter.dart';
import 'package:hairvibe/Singletons/barber_singleton.dart';
import 'package:hairvibe/Singletons/notification_singleton.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';
import 'package:hairvibe/observers/notification_subcriber.dart';
import 'package:hairvibe/widgets/custom_button.dart';
import 'package:hairvibe/widgets/noti_bell.dart';
import '../../Models/rating_model.dart';
import '../../widgets/util_widgets.dart';

class RatingBarberPage extends StatefulWidget {
  const RatingBarberPage({super.key});
  static const routeName = 'rating-barber';

  @override
  State<RatingBarberPage> createState() => _RatingBarberPageState();
}

class _RatingBarberPageState extends State<RatingBarberPage>
  implements RatingBarberContract, NotificationSubscriber {
  final NotificationSingleton notificationSingleton = NotificationSingleton.getInstance();
  RatingBarberPresenter? _presenter;

  int _soLuongThongBao = 0;
  double _ratingValue = 3;

  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    _presenter = RatingBarberPresenter(this);
    notificationSingleton.subscribe(this);
    _soLuongThongBao = notificationSingleton.getUnreadCount();
    RatingModel? rating = BarberSingleton.getInstance().thisUserRating;
    if (rating != null) {
      _ratingValue = rating.rate!;
      _reviewController.text = rating.info ?? "";
    }

    super.initState();
  }

  @override
  void dispose() {
    notificationSingleton.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Palette.primary,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          'REVIEW',
          style: TextDecor.homeTitle,
        ),
        centerTitle: true,
        actions: [
          NotificationBell(notificationCount: _soLuongThongBao),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Palette.primary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
              ),
              Text(
                'Star Rating',
                style: TextDecor.robo15Semi.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBar(
                initialRating: _ratingValue,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.yellow,
                  ),
                  half: const Icon(
                    FontAwesomeIcons.starHalfAlt,
                    color: Colors.yellow,
                  ),
                  empty: const Icon(
                    FontAwesomeIcons.star,
                    color: Colors.yellow,
                  ),
                ),
                itemSize: 30,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  _ratingValue = rating;
                },
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Review: ',
                style: TextDecor.robo15Semi.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _reviewController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                style: TextDecor.robo16Semi.copyWith(color: Colors.black),
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Please enter your reason',
                  hintStyle: TextDecor.inter12Medi,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                onPressed: () {
                  _presenter?.handleRating(_reviewController.text.trim(), _ratingValue);
                },
                text: 'CONFIRM',
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void onRatingFailed(String message) {
    UtilWidgets.createSnackBar(context, message);
  }

  @override
  void onRatingSucceeded() {
    UtilWidgets.createDialog(
        context,
        UtilWidgets.NOTIFICATION,
        "Review successfully!",
        () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  }

  @override
  void onPopContext() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void onWaitingProgressBar() {
    UtilWidgets.createLoadingWidget(context);
  }

  @override
  void updateNotification() {
    setState(() {
      _soLuongThongBao = notificationSingleton.getUnreadCount();
    });
  }
}
