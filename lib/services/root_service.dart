import 'package:full_db/services/nosql_sevice.dart';
import 'package:full_db/services/sql_service.dart';

class RootService{
  static Future<void> init() async {
    await SqlService.init();
    await NoSqlService.init();
  }
}