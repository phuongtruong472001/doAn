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
    this.icon,
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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      typeCategory: map['typeCategory'] != null ? map['typeCategory'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<Category> categories = [
  Category(
    id: 0,
    name: "Ăn uống",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 1,
    name: "Di chuyển",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 2,
    name: "Thuê nhà",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 3,
    name: "Hóa đơn nước",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 4,
    name: "Hóa đơn điện thoại",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 5,
    name: "Hóa đơn điện",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 6,
    name: "Hóa đơn gas",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 7,
    name: "Hóa đơn TV",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 8,
    name: "Hóa đơn internet",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 9,
    name: "Hóa đơn tiện ích khác",
    icon: "",
    typeCategory: TypeCategory.monthlySpending
  ),
  Category(
    id: 10,
    name: "Sửa & trang trí nnhaf",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 11,
    name: "Bảo dưỡng xe",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 12,
    name: "Khám sức khỏe",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 13,
    name: "Bảo hiểm",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 14,
    name: "Giáo dục",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 15,
    name: "Đồ gia dụng",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 16,
    name: "Đồ dùng cá nhân",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 17,
    name: "Vật nuôi",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 18,
    name: "Dịch vụ gia đình",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 19,
    name: "Các chị phí khác",
    icon: "",
    typeCategory: TypeCategory.necessarySpending
  ),
  Category(
    id: 20,
    name: "Thể dục thể thao",
    icon: "",
    typeCategory: TypeCategory.playSpending
  ),
  Category(
    id: 21,
    name: "Làm đẹp",
    icon: "",
    typeCategory: TypeCategory.playSpending
  ),
  Category(
    id: 22,
    name: "Quà tặng & Quyên góp",
    icon: "",
    typeCategory: TypeCategory.playSpending
  ),
  Category(
    id: 23,
    name: "Dịch vụ trực tuyến",
    icon: "",
    typeCategory: TypeCategory.playSpending
  ),
  Category(
    id: 24,
    name: "Vui - chơi",
    icon: "",
    typeCategory: TypeCategory.playSpending
  ),
  Category(
    id: 25,
    name: "Đầu tư",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 26,
    name: "Thu nợ",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 27,
    name: "Đi vay",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 28,
    name: "Cho vay",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 29,
    name: "Trả nợ",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 30,
    name: "Trả lãi",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 31,
    name: "Thu lãi",
    icon: "",
    typeCategory: TypeCategory.investSpending
  ),
  Category(
    id: 32,
    name: "Lương",
    icon: "",
    typeCategory: TypeCategory.revenueSpending
  ),
  Category(
    id: 33,
    name: "Thu nhập khác",
    icon: "",
    typeCategory: TypeCategory.revenueSpending
  ),
  Category(
    id: 34,
    name: "Tiền chuyển đến",
    icon: "",
    typeCategory: TypeCategory.otherSpending
  ),
  Category(
    id: 35,
    name: "Tiền chuyển đi",
    icon: "",
    typeCategory: TypeCategory.otherSpending
  ),
];
