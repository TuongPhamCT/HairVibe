abstract class VoucherRedeemContract {
  void onLoadDataSucceed();
  void onUseVoucher();
  void onRedeemSucceed();
  void onRedeemFailed(String message);
}