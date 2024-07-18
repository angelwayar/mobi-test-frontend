import 'package:image_picker/image_picker.dart';

// Entidad para guardar imagenes
class ImageEntity {
  final XFile image;

  const ImageEntity({required this.image});

  ImageEntity copyWith({XFile? image}) {
    return ImageEntity(
      image: image ?? this.image,
    );
  }
}

// Entidad para mostrar las imagenes
class ImageResultEntity {
  final String id;
  final String name;
  final String imageUrl;

  const ImageResultEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  ImageResultEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
  }) {
    return ImageResultEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
