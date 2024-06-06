class SqlCard {
  int? id;
  String? cardNumber;
  String? expiredDate;
  String? cardType;
  String? cardImage;

  SqlCard({this.id, this.cardNumber, this.expiredDate, this.cardType, this.cardImage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'expiredDate': expiredDate,
      'cardType': cardType,
      'cardImage': cardImage
    };
  }

  static SqlCard fromMap(Map map) {
    SqlCard sqlCard = SqlCard();
    sqlCard.id = map['id'];
    sqlCard.cardNumber = map['cardNumber'];
    sqlCard.expiredDate = map['expiredDate'];
    sqlCard.cardType = map['cardType'];
    sqlCard.cardImage = map['cardImage'];

    return sqlCard;
  }
}