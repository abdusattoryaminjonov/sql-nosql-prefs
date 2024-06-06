part of 'nosql_card.dart';

class CreditCardAdapter extends TypeAdapter<NoSqlCard> {
  @override
  final int typeId = 0;

  @override
  NoSqlCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoSqlCard(
      cardNumber: fields[0] as String?,
      expiredDate: fields[1] as String?,
      cardType: fields[2] as String?,
      cardImage: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NoSqlCard obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cardNumber)
      ..writeByte(1)
      ..write(obj.expiredDate)
      ..writeByte(2)
      ..write(obj.cardType)
      ..writeByte(3)
      ..write(obj.cardImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CreditCardAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}