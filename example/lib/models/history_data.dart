import 'package:arcore_flutter_plugin_example/models/plant_info.dart';
import 'package:arcore_flutter_plugin_example/models/remedy_info.dart';

class HistoryEntry {
  final List<PlantData> plants;
  final List<RemedyInfo> remedies;
  final String timestamp;

  HistoryEntry({
    required this.plants,
    required this.remedies,
    required this.timestamp,
  });

  factory HistoryEntry.fromMap(Map<String, dynamic> map) {
    return HistoryEntry(
      plants: List<PlantData>.from(
          map['plants']?.map((e) => PlantData.fromMap(e)) ?? []),
      remedies: List<RemedyInfo>.from(
          map['remedies']?.map((e) => RemedyInfo.fromMap(e)) ?? []),
      timestamp: map['timestamp'],
    );
  }
}
