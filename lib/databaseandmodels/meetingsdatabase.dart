import 'dart:io';

import 'package:confabmobile/softwarepackages.dart';

class SavedMeetingsDBHelper {
  static final SavedMeetingsDBHelper instance = SavedMeetingsDBHelper._instance();

  static Database database;

  SavedMeetingsDBHelper._instance();

  String meetingsTable = "confabmeetings";
  String columnCode = "meetingCode";
  String columnTitle = "meetingTitle";
  String columnDescription = "meetingDescription";
  String columnDateAndTime = "meetingDateAndTime";
  String columnMeetingLink = "meetingLink";

  Future<Database> get db async {
    database ??= await intializeDatabase();
    return database;
  }

  Future<Database> intializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databasepath = directory.path + "savedmeetings.db";
    final savedmeetingsdb = await openDatabase(databasepath, version: 1, onCreate: createNewDatabase);
    return savedmeetingsdb;
  }

  void createNewDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $meetingsTable($columnCode TEXT, $columnTitle TEXT, $columnDescription TEXT, $columnDateAndTime TEXT, $columnMeetingLink TEXT)",
    );
  }

  Future<List<Map<String, dynamic>>> fetchSavedMeetingsAsMap() async {
    Database database = await db;
    final List<Map<String, dynamic>> results = await database.query(meetingsTable);
    return results;
  }

  Future<List<SavedMeetingData>> fetchSavedMeetingsListing() async {
    final List<Map<String, dynamic>> savedMeetingsMappedList = await fetchSavedMeetingsAsMap();
    final List<SavedMeetingData> savedMeetingsList = [];

    for (var data in savedMeetingsMappedList) {
      if (data["meetingLink"].toString().contains("https://")) {
        savedMeetingsList.add(SavedMeetingData().fromMap(data));
      }
    }
    return savedMeetingsList;
  }

  insertSavedMeeting(SavedMeetingData savedMeetingData) async {
    Database database = await db;
    await database.insert(meetingsTable, savedMeetingData.toMap());
  }

  updatesavedmeeting(SavedMeetingData savedMeetingData) async {
    Database database = await db;
    await database.update(
      meetingsTable,
      savedMeetingData.toMap(),
      where: "$columnCode = ?",
      whereArgs: [savedMeetingData.meetingCode],
    );
  }

  deletesavedmeeting(String meetingCode) async {
    Database database = await db;
    database.delete(
      meetingsTable,
      where: "$columnCode = ?",
      whereArgs: [meetingCode],
    );
  }
}
