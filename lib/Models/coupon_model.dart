class CouponModel {
  String? couponID;
  String? title;
  int? discountRate;
  String? info;

  static String collectionName = 'Coupons';

  CouponModel(
      {
        required this.couponID,
        required this.title,
        required this.discountRate,
        this.info
      }
    );

  Map<String, dynamic> toJson() => {
    'couponID': couponID,
    'title': title,
    'discountRate': discountRate,
    'info': info
  };

  static CouponModel fromJson(Map<String, dynamic> json) {
    return CouponModel(
      couponID: json['couponID'] as String,
      title: json['title'] as String,
      discountRate: json['discountRate'] as int,
      info: json['info'] as String,
    );
  }
}