import 'dart:async';
import 'dart:io' as io;

import 'package:do_an/model/category.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/model/invoice.dart';
import 'package:do_an/model/transaction.dart' as tr;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  Future<List<tr.Transaction>> getTransactions(
      String fromDate, String toDate) async {
    var dbClient = await db;
    var transactions = await dbClient?.rawQuery(
        'SELECT * FROM Transactions where executionTime = "$fromDate" AND executionTime <= "$toDate"');
    List<tr.Transaction> listCategories = transactions!.isNotEmpty
        ? transactions.map((c) => tr.Transaction.fromMap(c)).toList()
        : [];
    return listCategories;
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

  Future<List<Invoice>> getInvoices() async {
    var dbClient = await db;
    var invoices = await dbClient?.query('Event');
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
    return status == 1;
  }

  Future<bool> addInvoice(Invoice invoice) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Invoice(value, description,eventID,category,executionTime,fundId,notificationTime,typeOfNotification,allowNegative,fundName,categoryName) VALUES(?,?,?, ?, ?, ?,?, ?, ?, ?,?)',
      [
        invoice.value,
        invoice.description,
        invoice.eventID,
        invoice.categoryID,
        DateFormat('yyyy-MM-dd').format(invoice.executionTime!),
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
      'INSERT INTO Transactions(value,description,eventId,categoryId,executionTime,fundID,categoryName,eventName,fundName,allowNegative,isIncrease) VALUES(?, ?, ?, ?, ?, ?,?,?,?,?,?)',
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
        transaction.isIncrease
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
      'Update Transactions SET value=${transaction.value},description=${transaction.description},eventId=${transaction.eventId},categoryId=${transaction.categoryId},executionTime=${transaction.executionTime},fundID=${transaction.fundID},categoryName=${transaction.categoryName},eventName=${transaction.eventName},fundName=${transaction.fundName} WHERE id=${transaction.id}',
    );
    return status != 0;
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
}
