import 'package:furqan/core/entities/audio_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_model.g.dart';

@JsonSerializable()
class AudioModel {
  final String recieter;
  final String url;
  final String originalUrl;

  AudioModel({
    required this.recieter,
    required this.url,
    required this.originalUrl,
  });

  factory AudioModel.fromJson(Map<String, dynamic> json) =>
      _$AudioModelFromJson(json);
  Map<String, dynamic> toJson() => _$AudioModelToJson(this);

  AudioEntity toEntity() {
    return AudioEntity(recieter: recieter, url: url, originalUrl: originalUrl);
  }
}
