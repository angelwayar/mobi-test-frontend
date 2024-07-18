import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/images.entity.dart';

class ImageRequestModel extends ImageEntity {
  const ImageRequestModel({
    required this.image,
  }) : super(image: image);

  final XFile image;

  Future<Map<String, dynamic>> toJson() async {
    var formData;

    if (image.path.isNotEmpty) {
      formData = await MultipartFile.fromFile(
        image.path,
        filename: image.name,
      );
    }

    return Future.value({
      "file": formData,
    });
  }
}

class ImageResponseModel extends ImageResultEntity {
  const ImageResponseModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) =>
      ImageResponseModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["url"],
      );
}
