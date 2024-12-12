// $table->id();
// $table->string('plant_name')->nullable(false);
// $table->string('scientific_name')->nullable();
// $table->text('description')->nullable();
// $table->text('additional_info')->nullable();
// $table->string('status')->nullable(false)->default('Pending');
// $table->boolean('is_accepted')->default(true);
// $table->foreignId('request_by')->constrained('users')->onDelete('cascade')->onUpdate('cascade');
// $table->foreignId('accept_by')->nullable()->constrained('users')->onDelete('cascade')->onUpdate('cascade');
// $table->timestamps();
import 'md_image.dart';
import 'md_user.dart';

class RequestPlantModel {
  int? id;
  String? scientific_name;
  String? description;
  List<ImageModel>? images;
  String? created_at;
  String? updated_at;

  RequestPlantModel({
    this.id,
    this.scientific_name,
    this.description,
    this.images,
    this.created_at,
    this.updated_at,
  });

  static List<RequestPlantModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => RequestPlantModel.fromJson(json)).toList();
  }

  RequestPlantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scientific_name = json['scientific_name'];
    description = json['description'];
    images = ImageModel.fromJsonList(json['images']);
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scientific_name'] = scientific_name;
    data['description'] = description;
    return data;
  }
}
