import 'package:iapetus/iapetus_data.dart';
import 'package:iapetus_meta/src/typing/value_types/pandora_entity.dart';
import 'package:iapetus_meta/src/typing/value_types/timestamp.dart';
import 'package:iapetus_meta/src/typing/value_types/value_type.dart';

bool likelyTimestampKey(String key) {
  final lowercaseKey = key.toLowerCase();
  return lowercaseKey.contains('last') ||
      lowercaseKey.contains('time') ||
      lowercaseKey.contains('date');
}

TimestampValueType<Object>? estimateTimestampValueType(Object? value) {
  final int? timestamp;
  if (value is int) {
    timestamp = value;
  } else if (value is String) {
    final dateTime = DateTime.tryParse(value);
    if (dateTime != null) return const DateValueType(optional: false);
    timestamp = int.tryParse(value);
  } else {
    timestamp = null;
  }
  if (timestamp == null) return null;
  if (timestamp >= 100000000000000000) {
    return null;
  }
  if (timestamp >= 100000000000000) {
    return const MicrosecondTimestampValueType(optional: false);
  }
  if (timestamp >= 100000000000) {
    return const MillisecondTimestampValueType(optional: false);
  }
  if (timestamp >= 100000000) {
    return const SecondTimestampValueType(optional: false);
  }
  return null;
}

bool likelyPandoraType(String value) => pandoraTypeEnumMap.containsValue(value);

bool likelyPandoraId(String value) {
  if (value.length < 4) return false;
  if (value[2] != ':') return false;
  if (!likelyPandoraType(value.substring(0, 2))) return false;
  if (value
      .substring(3)
      .split(':')
      .map(int.tryParse)
      .any((segment) => segment == null)) return false;
  return true;
}

// bool likelyPandoraTypeVariant(String key, )

bool likelyAnnotationMap(String key, ValueType keyType) =>
    key == 'annotations' && keyType is PandoraIdValueType;
