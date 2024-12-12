import 'dart:convert';

import 'package:arcore_flutter_plugin_example/models/data_model/md_ailment.dart';
import 'md_like.dart';
import 'md_plant_treatment.dart';

// {
//     "id": 22,
//     "name": "Ouret lanata",
//     "scientific_name": "Aerva lanata",
//     "local_name": "Bulak Manok",
//     "description": "Aerva lanata is a soft, perennial herb or shrub that thrives in tropical and subtropical regions. It typically grows in dry, rocky areas and is recognized by its woolly appearance due to small white hairs covering the stems and leaves. The plant produces small, greenish-white flowers and is commonly found in grasslands, roadsides, and waste areas.",
//     "total_likes": 1,
//     "status": "active",
//     "image_path": [
//         "http://192.168.1.21:8080/storage/plant_image/1733262879_Ouret lanata1.jpg",
//         "http://192.168.1.21:8080/storage/plant_image/1733262879_Ouret lanata2.jpg",
//         "http://192.168.1.21:8080/storage/plant_image/1733262879_Ouret lanata3.jpg",
//         "http://192.168.1.21:8080/storage/plant_image/1733262879_Ouret lanata4.jpg"
//     ],
//     "treatments": [
//         {
//             "id": 3,
//             "name": "Fever",
//             "description": "Abnormal rise in body temperature, often due to infection",
//             "type": "General",
//             "created_at": "2024-12-03T08:43:19.000000Z",
//             "updated_at": "2024-12-03T08:43:19.000000Z"
//         },
//         {
//             "id": 4,
//             "name": "Cough",
//             "description": "A sudden and repetitive reflex to clear the airways",
//             "type": "Respiratory",
//             "created_at": "2024-12-03T08:43:35.000000Z",
//             "updated_at": "2024-12-03T08:43:35.000000Z"
//         }
//     ],
//     "likes": [
//         {
//             "id": 2,
//             "like": 1,
//             "users": {
//                 "id": 3,
//                 "name": "Sherry Ann Aldave",
//                 "email": "ann@gmail.com",
//                 "email_verified_at": null,
//                 "role": "user",
//                 "status": "inactive",
//                 "avatar": null,
//                 "phone": null,
//                 "address": null,
//                 "gender": null,
//                 "birthday": null,
//                 "created_at": "2024-12-08T02:00:44.000000Z",
//                 "updated_at": "2024-12-08T02:00:44.000000Z"
//             }
//         }
//     ]
// },

class PlantModel {
  int? id;
  String? name;
  String? scientific_name;
  String? description;
  String? status;
  String? local_name;
  List<AilmentModel>? treatments;
  List<dynamic>? images;
  List<LikeModel>? likes;
  int? total_likes;
  String? created_at;
  String? updated_at;

  PlantModel({
    this.id,
    this.name,
    this.scientific_name,
    this.description,
    this.total_likes,
    this.status,
    this.local_name,
    this.treatments,
    this.images,
    this.likes,
    this.created_at,
    this.updated_at,
  });

  // List of plants from JSON
  static List<PlantModel> listFromJson(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => PlantModel.fromJson(json)).toList();
  }

  PlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'None';
    scientific_name = json['scientific_name'] ?? 'None';
    description = json['description'] ?? 'None';
    total_likes = json['total_likes'] ?? 0;
    status = json['status'] ?? 'inactive';
    local_name = json['local_name'] ?? 'None';
    images = json['image_path'] ?? [];
    treatments = AilmentModel.listFromJson(json['treatments']);
    created_at = json['created_at'] ?? 'None';
    updated_at = json['updated_at'] ?? 'None';
  }
}
