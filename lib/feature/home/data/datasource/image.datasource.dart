import '../models/image.model.dart';

abstract interface class ImageDataSource {
  Future<void> deleteImage({required String id});
  Future<List<ImageResponseModel>> getAllImages();
  Future<void> saveImage({required List<ImageRequestModel> imagesModel});
}
