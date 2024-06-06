import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/nosql_card.dart';

class NoSqlService {
  static var box = Hive.box('my_nosql');

  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(CreditCardAdapter());
    await Hive.openBox("my_nosql");
  }

  /// Save object without key
  static saveNoSqlCard(NoSqlCard noSql) async {
    box.add(noSql);
  }

  static updateNoSqlCard(int index,NoSqlCard noSql) async {
    box.putAt(index, noSql);
  }

  static List<NoSqlCard> fetchNoSqlCard() {
    List<NoSqlCard> noSql = [];
    for (int i = 0; i < box.length; i++) {
      var card = box.getAt(i);
      noSql.add(card);
    }
    return noSql;
  }

  static deleteNoSqlCardByIndex(int index) async {
    box.deleteAt(index);
  }
}