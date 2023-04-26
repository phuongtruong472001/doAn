import 'dart:async';
import 'dart:io' as io;

import 'package:do_an/model/category.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/model/invoice.dart';
import 'package:do_an/model/transaction.dart' as tr;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "do_an.db");
    bool dbExists = await io.File(path).exists();
    print("Database: $path");

    if (!dbExists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "do_an.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(path).writeAsBytes(bytes, flush: true);
    }

    var theDb = await openDatabase(
      path,
      version: 1,
    );
    return theDb;
  }

  Future<List<Category>> getCategories() async {
    var dbClient = await db;
    var categories = await dbClient?.query('Category');
    List<Category> listCategories = categories!.isNotEmpty
        ? categories.map((c) => Category.fromMap(c)).toList()
        : [];
    return listCategories;
  }

  Future<List<tr.Transaction>> getTransactions(String fromDate, String toDate,
      {String keySearch = ""}) async {
    var dbClient = await db;
    //  var transactions = await dbClient?.rawQuery(
    //     'INSERT INTO Transactions(value,description,eventId,categoryId,executionTime,fundID,categoryName,eventName,fundName,allowNegative,isIncrease,isRepeat,typeTime,typeRepeat) VALUES(200000,"",0,0,"2023-04-20",0,"Ăn uống","","Tiền mặt",1,1,1,0,0)');
    var transactions = await dbClient?.rawQuery(
        'SELECT * FROM Transactions where executionTime >= "$fromDate" AND executionTime <= "$toDate" AND description LIKE "%$keySearch%" OR categoryName LIKE "%$keySearch%" ORDER BY executionTime DESC');
    List<tr.Transaction> listTransactions = transactions!.isNotEmpty
        ? transactions.map((c) => tr.Transaction.fromMap(c)).toList()
        : [];
    return listTransactions;
  }

  Future<List<tr.Transaction>> getTransactionsByName(String keySearch) async {
    var dbClient = await db;
    //  var transactions = await dbClient?.rawQuery(
    //     'INSERT INTO Transactions(value,description,eventId,categoryId,executionTime,fundID,categoryName,eventName,fundName,allowNegative,isIncrease,isRepeat,typeTime,typeRepeat) VALUES(200000,"",0,0,"2023-04-20",0,"Ăn uống","","Tiền mặt",1,1,1,0,0)');
    var transactions = await dbClient?.rawQuery(
        'SELECT * FROM Transactions WHERE Transactions.description LIKE "%$keySearch%" OR Transactions.categoryName LIKE "%$keySearch%"  ORDER BY Transactions.executionTime DESC');
    List<tr.Transaction> listTransactions = transactions!.isNotEmpty
        ? transactions.map((c) => tr.Transaction.fromMap(c)).toList()
        : [];
    return listTransactions;
  }

  Future<List<tr.Transaction>> getTransactionsOfFund(
      String fromDate, String toDate, int fundID) async {
    var dbClient = await db;
    var transactions = await dbClient?.rawQuery(
        'SELECT * FROM Transactions WHERE fundID = $fundID ORDER BY executionTime DESC');
    List<tr.Transaction> listTransactions = transactions!.isNotEmpty
        ? transactions.map((c) => tr.Transaction.fromMap(c)).toList()
        : [];
    return listTransactions;
  }

  Future<List<Event>> getEvents() async {
    var dbClient = await db;
    var events = await dbClient?.query('Event');
    List<Event> listEvents =
        events!.isNotEmpty ? events.map((c) => Event.fromjson(c)).toList() : [];
    return listEvents;
  }

  Future<List<Fund>> getFunds() async {
    var dbClient = await db;
    var funds = await dbClient?.query('Fund');
    List<Fund> listFunds =
        funds!.isNotEmpty ? funds.map((c) => Fund.fromMap(c)).toList() : [];
    return listFunds;
  }

  Future<List<Invoice>> getInvoices(int allowNegative) async {
    var dbClient = await db;
    var invoices = await dbClient?.rawQuery(
        'SELECT * FROM Invoice where Invoice.allowNegative = $allowNegative');
    List<Invoice> listInvoices = invoices!.isNotEmpty
        ? invoices.map((c) => Invoice.fromMap(c)).toList()
        : [];
    return listInvoices;
  }

  Future<bool> addFund(Fund fund) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Fund(name,icon,value,allowNegative) VALUES(?, ?, ?, ?)',
      [
        fund.name,
        fund.icon,
        fund.value,
        fund.allowNegative,
      ],
    );
    return status != 0;
  }

  Future<bool> addEvent(Event event) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Event(name,icon,date,estimateValue,allowNegative) VALUES(?, ?, ?, ?,?)',
      [
        event.name,
        event.icon,
        event.date!.toIso8601String(),
        event.estimateValue,
        event.allowNegative
      ],
    );
    return status != 0;
  }

  Future<bool> addInvoice(Invoice invoice) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Invoice(value, description,eventID,categoryID,executionTime,fundId,notificationTime,typeOfNotification,allowNegative,fundName,categoryName) VALUES(?,?,?, ?, ?, ?,?, ?, ?, ?,?)',
      [
        invoice.value,
        invoice.description,
        invoice.eventID,
        invoice.categoryID,
        DateFormat('yyyy-MM-dd')
            .format(invoice.executionTime ?? DateTime.now()),
        invoice.fundId,
        invoice.notificationTime,
        invoice.typeOfNotification,
        invoice.allowNegative,
        invoice.fundName,
        invoice.categoryName
      ],
    );
    return status != 0;
  }

  Future<bool> addTransaction(tr.Transaction transaction) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Transactions(value,description,eventId,categoryId,executionTime,fundID,categoryName,eventName,fundName,allowNegative,isIncrease,isRepeat,typeTime,typeRepeat,endTime) VALUES(?, ?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?)',
      [
        transaction.value,
        transaction.description,
        transaction.eventId,
        transaction.categoryId,
        DateFormat('yyyy-MM-dd kk:mm').format(transaction.executionTime!),
        transaction.fundID,
        transaction.categoryName,
        transaction.eventName,
        transaction.fundName,
        transaction.allowNegative,
        transaction.isIncrease,
        transaction.isRepeat == true ? 1 : 0,
        transaction.typeTime,
        transaction.typeRepeat,
        DateFormat('yyyy-MM-dd kk:mm').format(transaction.endTime!),
      ],
    );
    if (status != 0) {
      await updateFund(transaction);
      if (transaction.eventId! >= 0) {
        updateEvent(transaction);
      }
    }
    return status != 0;
  }

  Future<String> getNameOfCategory(int id) async {
    var dbClient = await db;
    var category =
        await dbClient?.rawQuery('SELECT * FROM Category WHERE id = ?', [id]);
    return category![0]["name"] as String;
  }

  //edit records
  Future<void> updateFund(
    tr.Transaction transaction,
  ) async {
    var dbClient = await db;
    await dbClient?.rawInsert(
      'Update  Fund SET value=value+ ${transaction.value} WHERE id=${transaction.fundID}',
    );
  }

  Future<bool> editEvent(Event event) async {
    var dbClient = await db;
    var status = await dbClient?.rawUpdate(
      'Update Event SET name=${event.name},icon=${event.icon},date=${event.date},estimate =${event.estimateValue} WHERE id=${event.id}',
    );
    return status == 1;
  }

  Future<bool> editInvoice(Invoice invoice) async {
    var dbClient = await db;
    var status = await dbClient?.rawUpdate(
      'Update  Invoice SET value=${invoice.value}, description=${invoice.description},eventID=${invoice.eventID},category=${invoice.categoryID},executionTime=${invoice.executionTime},fundId=${invoice.fundId},notificationTime=${invoice.notificationTime},typeOfNotification=${invoice.typeOfNotification} WHERE id=${invoice.id}',
    );
    return status == 1;
  }

  Future<bool> editTransaction(tr.Transaction transaction) async {
    var dbClient = await db;
    var status = await dbClient?.rawUpdate(
      'Update Transactions SET value=${transaction.value}  WHERE id=${transaction.id}',
    );
    return status == 0;
  }

  //delete records
  Future<bool> deleteFund(Fund fund) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'Update  Fund SET allowNegative=0 WHERE id=${fund.id}',
    );
    return status != 0;
  }

  Future<bool> deleteEvent(Event event) async {
    var dbClient = await db;
    var status = await dbClient?.rawUpdate(
      'Update Event SET allowNegative=0 WHERE id=${event.id}',
    );
    return status == 1;
  }

  Future<bool> deleteInvoice(Invoice invoice) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'Update Invoice SET allowNegative=0 WHERE id=${invoice.id}',
    );
    return status == 1;
  }

  Future<bool> deleteTransaction(tr.Transaction transaction) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'DELETE FROM  Transaction WHERE id=${transaction.id}',
    );
    return status != 0;
  }
  //update record

  Future<void> updateEvent(
    tr.Transaction transaction,
  ) async {
    var dbClient = await db;
    await dbClient?.rawInsert(
      'Update Event SET value=value+ ${transaction.value} WHERE id=${transaction.eventId}',
    );
  }

  Future<int> getTotalValueOfCategory(
    int categoryID,
    String fromDate,
    String toDate,
  ) async {
    var dbClient = await db;
    var transactions = await dbClient?.rawQuery(
        'SELECT SUM(value) as Total FROM Transactions where categoryId=$categoryID');
    int sumValues =
        transactions!.isNotEmpty ? transactions[0]["Total"] as int : 0;
    return sumValues;
  }

  Future<int> getTotalValue(
    String fromDate,
    String toDate,
  ) async {
    var dbClient = await db;
    var transactions =
        await dbClient?.rawQuery('SELECT SUM(value) as Total FROM Fund');
    int sumValues =
        transactions!.isNotEmpty ? transactions[0]["Total"] as int : 0;
    return sumValues;
  }

  Future<int> getTotalValueOfCash() async {
    var dbClient = await db;
    var fund = await dbClient?.rawQuery('SELECT value  FROM Fund where id=0');
    int sumValues = fund!.isNotEmpty ? fund[0]["value"] as int : 0;
    return sumValues;
  }

  Future<int> getValueOfMonth(String fromDate, String toDate) async {
    var dbClient = await db;
    var transactions = await dbClient?.rawQuery(
        'SELECT SUM(value) as Total FROM Transactions where where executionTime = "$fromDate" AND executionTime <= "$toDate" AND value<0');
    int sumValues =
        transactions!.isNotEmpty ? transactions[0]["value"] as int : 0;
    return sumValues;
  }

  Future<void> autoGenerateTransaction() async {
    List<tr.Transaction> transactions =
        await getTransactions("2023-01-01", "2023-05-01");
    for (tr.Transaction transaction in transactions) {
      if (transaction.isRepeat == true) {
        if (transaction.typeRepeat == 0) {
          var now = DateTime.now();
          print("endtime${transaction.endTime}");
          var tempDate = Jiffy(transaction.endTime ?? DateTime.now());
          while (Jiffy(now).isAfter(tempDate)) {
            if (transaction.typeTime == 0) {
              tempDate = Jiffy(tempDate).add(duration: const Duration(days: 1));
            } else if (transaction.typeTime == 1) {
              tempDate = Jiffy(tempDate).add(weeks: 1);
            } else {
              tempDate = Jiffy(tempDate).add(months: 1);
            }

            if (Jiffy(now).isAfter(Jiffy(tempDate))) {
              transaction.endTime = tempDate.dateTime;
              tr.Transaction tempTransaction = transaction;
              tempTransaction.executionTime = tempDate.dateTime;
              tempTransaction.isRepeat = false;
              await addTransaction(tempTransaction);
            } else {
              break;
            }
          }
        } else {
          if (Jiffy(transaction.endTime).isSameOrAfter(Jiffy(DateTime.now()))) {
            tr.Transaction tempTransaction = transaction;
            tempTransaction.executionTime = transaction.endTime;
            transaction.isRepeat = false;
            tempTransaction.isRepeat = false;
            await addTransaction(tempTransaction);
          }
        }
      }
    }
  }
}
