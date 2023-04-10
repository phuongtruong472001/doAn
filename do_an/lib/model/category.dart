import 'dart:convert';

import 'package:do_an/enum/type_category.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  int? id;
  String? name;
  String? icon;
  int? typeCategory;
  Category({
    this.id,
    this.name,
    this.typeCategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'typeCategory': typeCategory,
    };
  }

  factory Category.fromMap(
    Map<String, dynamic> map,
  ) {
    return Category(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      typeCategory:
          map['typeCategory'] != null ? map['typeCategory'] as int : null,
    );
  }

  String toJson() => json.encode(
        toMap(),
      );

  factory Category.fromJson(
    String source,
  ) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<Category> categories = [
  Category(
    id: 0,
    name: "Ăn uống",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 1,
    name: "Di chuyển",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 2,
    name: "Thuê nhà",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 3,
    name: "Hóa đơn nước",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 4,
    name: "Hóa đơn điện thoại",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 5,
    name: "Hóa đơn điện",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 6,
    name: "Hóa đơn gas",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 7,
    name: "Hóa đơn TV",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 8,
    name: "Hóa đơn internet",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 9,
    name: "Hóa đơn tiện ích khác",
    typeCategory: TypeCategory.monthlySpending,
  ),
  Category(
    id: 10,
    name: "Sửa & trang trí nhà",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 11,
    name: "Bảo dưỡng xe",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 12,
    name: "Khám sức khỏe",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 13,
    name: "Bảo hiểm",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 14,
    name: "Giáo dục",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 15,
    name: "Đồ gia dụng",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 16,
    name: "Đồ dùng cá nhân",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 17,
    name: "Vật nuôi",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 18,
    name: "Dịch vụ gia đình",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 19,
    name: "Các chi phí khác",
    typeCategory: TypeCategory.necessarySpending,
  ),
  Category(
    id: 20,
    name: "Thể dục thể thao",
    typeCategory: TypeCategory.playSpending,
  ),
  Category(
    id: 21,
    name: "Làm đẹp",
    typeCategory: TypeCategory.playSpending,
  ),
  Category(
    id: 22,
    name: "Quà tặng & Quyên góp",
    typeCategory: TypeCategory.playSpending,
  ),
  Category(
    id: 23,
    name: "Dịch vụ trực tuyến",
    typeCategory: TypeCategory.playSpending,
  ),
  Category(
    id: 24,
    name: "Vui - chơi",
    typeCategory: TypeCategory.playSpending,
  ),
  Category(
    id: 25,
    name: "Đầu tư",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 26,
    name: "Thu nợ",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 27,
    name: "Đi vay",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 28,
    name: "Cho vay",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 29,
    name: "Trả nợ",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 30,
    name: "Trả lãi",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 31,
    name: "Thu lãi",
    typeCategory: TypeCategory.investSpending,
  ),
  Category(
    id: 32,
    name: "Lương",
    typeCategory: TypeCategory.revenueSpending,
  ),
  Category(
    id: 33,
    name: "Thu nhập khác",
    typeCategory: TypeCategory.revenueSpending,
  ),
  Category(
    id: 34,
    name: "Tiền chuyển đến",
    typeCategory: TypeCategory.otherSpending,
  ),
  Category(
    id: 35,
    name: "Tiền chuyển đi",
    typeCategory: TypeCategory.otherSpending,
  ),
];
