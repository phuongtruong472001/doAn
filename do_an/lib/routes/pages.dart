import 'package:do_an/pages/add_name/binding/add_name_binding.dart';
import 'package:do_an/pages/add_name/view/add_name_view.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/binding/bottom_navigation_bar_home_binding.dart';
import 'package:do_an/pages/bottom_navigation_bar_home/view/bottom_navigation_bar_home_view.dart';
import 'package:do_an/pages/category/binding/category_binding.dart';
import 'package:do_an/pages/category/view/category_view.dart';
import 'package:do_an/pages/create_event/binding/create_event_binding.dart';
import 'package:do_an/pages/create_event/view/create_event_view.dart';
import 'package:do_an/pages/create_fund/binding/create_fund_binding.dart';
import 'package:do_an/pages/create_fund/view/create_fund_view.dart';
import 'package:do_an/pages/create_invoice/binding/create_invoice_binding.dart';
import 'package:do_an/pages/create_invoice/view/create_invoice_view.dart';
import 'package:do_an/pages/create_transaction/binding/create_transaction_binding.dart';
import 'package:do_an/pages/create_transaction/view/create_transaction_view.dart';
import 'package:do_an/pages/detail_invoice/binding/detail_invoice_binding.dart';
import 'package:do_an/pages/detail_transaction/binding/detail_transaction_binding.dart';
import 'package:do_an/pages/detail_transaction/view/detail_transaction_view.dart';
import 'package:do_an/pages/event/binding/event_binding.dart';
import 'package:do_an/pages/event/view/event_view.dart';
import 'package:do_an/pages/fund/binding/fund_binding.dart';
import 'package:do_an/pages/home/binding/home_binding.dart';
import 'package:do_an/pages/home/view/home_view.dart';
import 'package:do_an/pages/transactions_of_fund/binding/transactions_of_fund_binding.dart';
import 'package:do_an/pages/transactions_of_fund/view/transactions_of_fund_view.dart';
import 'package:get/get.dart';

import '../pages/detail_invoice/view/detail_invoice_view.dart';
import '../pages/fund/view/fund_view.dart';
import '../pages/invoice/binding/invoice_binding.dart';
import '../pages/invoice/view/invoice_view.dart';
import 'routes.dart';

class RoutePage {
  static var route = [
    GetPage(
      name: AppRoutes.editName,
      page: () => const AddName(),
      binding: AddNameBinding(),
    ),
    GetPage(
      name: AppRoutes.pageBuilder,
      page: () => const BottomNavigationBarHomePage(),
      binding: BottomNavigationBarHomeBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.createTransaction,
      page: () => const CreateTransactionPage(),
      binding: CreateTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.detailTransaction,
      page: () => const DetailTransactionPage(),
      binding: DetailTransactionBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.fund,
      page: () => const FundPage(),
      binding: FundBinding(),
    ),
    GetPage(
      name: AppRoutes.event,
      page: () => const EventPage(),
      binding: EventBinding(),
    ),
    GetPage(
      name: AppRoutes.createFund,
      page: () => const CreateFundPage(),
      binding: CreateFundBinding(),
    ),
    GetPage(
      name: AppRoutes.createEvent,
      page: () => const CreateEventPage(),
      binding: CreateEventBinding(),
    ),
    GetPage(
      name: AppRoutes.createInvoice,
      page: () => const CreateInvoicePage(),
      binding: CreateInvoiceBinding(),
    ),
    GetPage(
      name: AppRoutes.invoice,
      page: () => const InvoicePage(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: AppRoutes.transactionsOfFund,
      page: () => const TransactionsOfFundPage(),
      binding: TransactionsOfFundBinding(),
    ),
    GetPage(
      name: AppRoutes.detailInvoice,
      page: () => const DetailInvoicePage(),
      binding: DetailInvoiceBinding(),
    ),
  ];
}
