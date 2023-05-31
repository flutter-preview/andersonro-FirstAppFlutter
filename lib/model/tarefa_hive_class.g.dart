// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarefa_hive_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TarefaHiveModelAdapter extends TypeAdapter<TarefaHiveModel> {
  @override
  final int typeId = 1;

  @override
  TarefaHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TarefaHiveModel(
      fields[1] as String,
      fields[2] as bool,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, TarefaHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.concluido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TarefaHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
