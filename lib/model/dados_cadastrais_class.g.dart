// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_cadastrais_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DadosCadastraisModelAdapter extends TypeAdapter<DadosCadastraisModel> {
  @override
  final int typeId = 0;

  @override
  DadosCadastraisModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DadosCadastraisModel(
      fields[0] as String?,
      fields[1] as DateTime?,
      fields[2] as String?,
      (fields[3] as List).cast<String>(),
      fields[4] as int,
      fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DadosCadastraisModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._nome)
      ..writeByte(1)
      ..write(obj._dataNascimento)
      ..writeByte(2)
      ..write(obj._nivelExperiencia)
      ..writeByte(3)
      ..write(obj._liguangens)
      ..writeByte(4)
      ..write(obj._tempoExperiencia)
      ..writeByte(5)
      ..write(obj._salario);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DadosCadastraisModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
