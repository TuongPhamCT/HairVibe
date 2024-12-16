abstract class CouponTabContract {
  void onLoadCoupons();
  void onCouponSelected(String couponId);
  void onCouponApplied(String couponId);
  void onCouponRemoved(String couponId);
}