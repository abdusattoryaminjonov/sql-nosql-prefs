import 'package:hive/hive.dart';
part 'nosql_card_model.g.dart';

@HiveType(typeId: 0)
class NoSqlCard extends HiveObject {

  @HiveField(0)
  late String? cardNumber;

  @HiveField(1)
  late String? expiredDate;

  @HiveField(2)
  late String? cardType;

  @HiveField(3)
  late String? cardImage;

  NoSqlCard({this.cardNumber, this.expiredDate, this.cardType, this.cardImage});
}