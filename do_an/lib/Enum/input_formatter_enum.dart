class InputFormatterEnum {
  /// 0 : LengthLimitingText. Giới hạn ký tự nhập(nếu có)
  static const lengthLimitingText = 0;

  /// 1 : digitsOnly. Chỉ nhập số
  static const digitsOnly = 1;

  /// 2 : TaxCode. Kiểu nhập là mã số thuế
  static const taxCode = 2;

  /// 3 : Không cho nhập các ký tự đặc biệt. dấu cách
  static const textOnly = 3;

  /// 4 : Nhập giá trị tiền
  static const currency = 4;

  /// 5 : Cho phép nhập giá trị âm
  static const negativeNumber = 5;

  /// 6 : Cho phép nhập giá trị thập phân
  static const decimalNumber = 6;

  /// 7 : Cho phép nhập giá trị căn cước
  static const identity = 7;

  /// 8 : cho phép nhập giá trị là số điện thoại
  static const phoneNumber = 8;

  /// 9 : cho phép nhập giá trị là email
  static const email = 9;
}
