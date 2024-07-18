import '../entities/images.entity.dart';

abstract interface class ImageRespository {
  Future<void> deleteImage({required String id});
  Future<List<ImageResultEntity>> getAllImage();
  Future<void> saveImage({required List<ImageEntity> images});
}
