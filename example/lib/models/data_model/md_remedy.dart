import 'dart:convert';

import 'package:arcore_flutter_plugin_example/models/data_model/md_ailment.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_ingredient.dart';
import 'package:arcore_flutter_plugin_example/models/data_model/md_plant.dart';

import 'md_rating.dart';
import 'md_remedy_treatment.dart';

//     "data": [
//         {
//             "id": 1,
//             "name": "Remedy1",
//             "type": "Type Remedy1",
//             "description": "this is Remedy1description",
//             "status": "active",
//             "average_rating": 3,
//             "step": [
//                 "step1 desc",
//                 "step2 desc"
//             ],
//             "side_effect": [
//                 "side effect 1 desc",
//                 "side effect 2 desc"
//             ],
//             "usage_remedy": [
//                 "usage1 desc",
//                 "usage2 desc"
//             ],
//             "image": [
//                 "http://192.168.1.21:8080/storage/remedy_image/1733440688_Remedy11.jpg"
//             ],
//      "user_ratings": [
//        {
//         "id": 1,
//         "rate": "4.00",
//         "users": {
//             "id": 2,
//             "name": "Joel Gutlay",
//             "email": "jo@gmail.com",
//             "email_verified_at": null,
//             "role": "user",
//             "status": "active",
//             "avatar": null,
//             "phone": null,
//             "address": null,
//             "gender": null,
//             "birthday": null,
//             "created_at": "2024-12-07T04:06:39.000000Z",
//             "updated_at": "2024-12-07T06:44:26.000000Z"
//         }
//     },
//     {
//         "id": 3,
//         "rate": "2.00",
//         "users": {
//             "id": 3,
//             "name": "Sherry Ann Aldave",
//             "email": "ann@gmail.com",
//             "email_verified_at": null,
//             "role": "user",
//             "status": "inactive",
//             "avatar": null,
//             "phone": null,
//             "address": null,
//             "gender": null,
//             "birthday": null,
//             "created_at": "2024-12-08T02:00:44.000000Z",
//             "updated_at": "2024-12-08T02:00:44.000000Z"
//         }
//     }
// ],
//             "treatments": [
//                 {
//                     "id": 5,
//                     "name": "Skin Rash",
//                     "description": "Redness or irritation of the skin",
//                     "type": "Dermatological",
//                     "created_at": "2024-12-03T08:43:57.000000Z",
//                     "updated_at": "2024-12-03T08:43:57.000000Z"
//                 },
//                 {
//                     "id": 4,
//                     "name": "Cough",
//                     "description": "A sudden and repetitive reflex to clear the airways",
//                     "type": "Respiratory",
//                     "created_at": "2024-12-03T08:43:35.000000Z",
//                     "updated_at": "2024-12-03T08:43:35.000000Z"
//                 }
//             ],
//             "tagged_plants": [
//                 {
//                     "id": 26,
//                     "name": "Butterfly Pea",
//                     "scientific_name": "Clitoria ternatea",
//                     "local_name": "Pukingan",
//                     "description": "A climbing vine with vibrant blue flowers, revered for its health benefits and ornamental beauty.",
//                     "status": "active",
//                     "image_path": [
//                         "http://192.168.1.21:8080/storage/plant_image/1733264228_Butterfly Pea1.jpg",
//                         "http://192.168.1.21:8080/storage/plant_image/1733264229_Butterfly Pea2.jpg",
//                         "http://192.168.1.21:8080/storage/plant_image/1733264229_Butterfly Pea3.jpg",
//                         "http://192.168.1.21:8080/storage/plant_image/1733264229_Butterfly Pea4.jpg"
//                     ],
//                     "treatments": [
//                         {
//                             "id": 14,
//                             "name": "Insomnia",
//                             "description": "Difficulty falling or staying asleep",
//                             "type": "Neurological",
//                             "created_at": "2024-12-03T08:46:57.000000Z",
//                             "updated_at": "2024-12-03T08:46:57.000000Z"
//                         },
//                         {
//                             "id": 1,
//                             "name": "Headache",
//                             "description": "Pain in the head or upper neck region",
//                             "type": "Neurological",
//                             "created_at": "2024-12-03T08:40:13.000000Z",
//                             "updated_at": "2024-12-03T08:40:13.000000Z"
//                         }
//                     ]
//                 },
//                 {
//                     "id": 30,
//                     "name": "Sal Leaved Desmodium",
//                     "scientific_name": "Desmodium gangeticum",
//                     "local_name": "Tugas-tugas",
//                     "description": "A small herbaceous plant known for its antipyretic and digestive health benefits.",
//                     "status": "active",
//                     "image_path": [
//                         "http://192.168.1.21:8080/storage/plant_image/1733264698_Sal Leaved Desmodium1.jpg",
//                         "http://192.168.1.21:8080/storage/plant_image/1733264698_Sal Leaved Desmodium2.jpg",
//                         "http://192.168.1.21:8080/storage/plant_image/1733264698_Sal Leaved Desmodium3.jpg",
//                         "http://192.168.1.21:8080/storage/plant_image/1733264698_Sal Leaved Desmodium4.jpg"
//                     ],
//                     "treatments": [
//                         {
//                             "id": 6,
//                             "name": "Stomachache",
//                             "description": "Pain in the abdominal area",
//                             "type": "Digestive",
//                             "created_at": "2024-12-03T08:44:18.000000Z",
//                             "updated_at": "2024-12-03T08:44:18.000000Z"
//                         }
//                     ]
//                 }
//             ]
//         },

class RemedyModel {
  int? id;
  String? name;
  String? type;
  String? description;
  String? status;
  double? average_rating;
  List<dynamic>? steps;
  List<dynamic>? side_effect;
  List<dynamic>? usage_remedy;
  List<IngredientModel>? ingredients;
  List<dynamic>? image_path;
  List<RatingModel>? user_ratings;
  List<AilmentModel>? treatments;
  List<PlantModel>? tagged_plants;
  String? created_at;
  String? updated_at;

  RemedyModel({
    this.id,
    this.name,
    this.type,
    this.description,
    this.status,
    this.average_rating,
    this.ingredients,
    this.steps,
    this.side_effect,
    this.usage_remedy,
    this.image_path,
    this.user_ratings,
    this.treatments,
    this.tagged_plants,
    this.created_at,
    this.updated_at,
  });

  static List<RemedyModel> fromJsonList(List list) {
    if (list.isEmpty) return [];
    return list.map((item) => RemedyModel.fromJson(item)).toList();
  }

  RemedyModel.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id'].toString()) ?? 0;
    name = json['name'] ?? 'Unknown';
    type = json['type'] ?? 'Unknown';
    description = json['description'] ?? 'None';
    status = json['status'] ?? 'inactive';
    average_rating = double.tryParse(json['average_rating'].toString()) ?? 0;
    ingredients = IngredientModel.listFromJson(json['ingredients'] ?? []);
    steps = json['step'] ?? [];
    side_effect = json['side_effect'] ?? [];
    usage_remedy = json['usage_remedy'] ?? [];
    image_path = json['image_path'] ?? [];
    user_ratings = RatingModel.listFromJson(json['user_ratings'] ?? []);
    treatments = AilmentModel.listFromJson(json['treatments'] ?? []);
    tagged_plants = PlantModel.listFromJson(json['tagged_plants'] ?? []);
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}
