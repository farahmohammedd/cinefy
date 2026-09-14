// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as int,
      title: fields[1] as String,
      posterPath: fields[2] as String,
      backdropPath: fields[3] as String,
      overview: fields[4] as String,
      voteAverage: fields[5] as double,
      voteCount: fields[6] as int,
      releaseDate: fields[7] as String,
      genreIds: (fields[8] as List).cast<int>(),
      runtime: fields[9] as int?,
      genres: (fields[10] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.backdropPath)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.voteCount)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.genreIds)
      ..writeByte(9)
      ..write(obj.runtime)
      ..writeByte(10)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
