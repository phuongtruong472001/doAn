import 'dart:async';
import 'dart:io' as io;

import 'package:do_an/model/category.dart';
import 'package:do_an/model/event.dart';
import 'package:do_an/model/fund.dart';
import 'package:do_an/model/invoice.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:do_an/model/transaction.dart' as tr;

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
    print("Database: " + path);

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

  Future<List<tr.Transaction>> getTransactions() async {
    var dbClient = await db;
    var transactions = await dbClient?.query('Transactions');
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
      'INSERT INTO Event(name,icon,date,estimateValue,,allowNegative) VALUES(?, ?, ?, ?,?)',
      [
        event.name,
        event.icon,
        event.date,
        event.estimateValue,
        event.allowNegative
      ],
    );
    return status == 1;
  }

  Future<bool> addInvoice(Invoice invoice) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Invoice(value, description,eventID,category,executionTime,fundId,notificationTime,typeOfNotification,allowNegative) VALUES(?, ?, ?, ?,?, ?, ?, ?,?)',
      [
        invoice.value,
        invoice.description,
        invoice.eventID,
        invoice.category,
        invoice.executionTime,
        invoice.fundId,
        invoice.notificationTime,
        invoice.typeOfNotification,
        invoice.allowNegative
      ],
    );
    return status != 0;
  }

  Future<bool> addTransaction(tr.Transaction transaction) async {
    var dbClient = await db;
    var status = await dbClient?.rawInsert(
      'INSERT INTO Transactions(value,description,eventId,categoryId,executionTime,fundID,categoryName,eventName,fundName,,allowNegative) VALUES(?, ?, ?, ?, ?, ?,?,?,?,?)',
      [
        transaction.value,
        transaction.description,
        transaction.eventId,
        transaction.categoryId,
        transaction.executionTime,
        transaction.fundID,
        transaction.categoryName,
        transaction.eventName,
        transaction.fundName,
        transaction.allowNegative
      ],
    );
    if (status != 0) {}
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
      'Update  Fund SET value=value+ ${transaction.value} WHERE id=${transaction.id}',
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
      'Update  Invoice SET value=${invoice.value}, description=${invoice.description},eventID=${invoice.eventID},category=${invoice.category},executionTime=${invoice.executionTime},fundId=${invoice.fundId},notificationTime=${invoice.notificationTime},typeOfNotification=${invoice.typeOfNotification} WHERE id=${invoice.id}',
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
      'Update Event SET value=value+ ${transaction.value} WHERE id=${transaction.id}',
    );
  }

  
}
