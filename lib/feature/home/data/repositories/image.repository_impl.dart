import '../../domain/entities/images.entity.dart';
import '../../domain/repositories/image.repository.dart';
import '../datasource/image.datasource.dart';
import '../models/image.model.dart';

class ImageRepositoryImpl implements ImageRespository {
  ImageRepositoryImpl(this._imageDataSource);

  final ImageDataSource _imageDataSource;

  @override
  Future<List<ImageResultEntity>> getAllImage() async {
    return await _imageDataSource.getAllImages();
  }

  @override
  Future<void> saveImage({required List<ImageEntity> images}) async {
    final imagesModel = images
        .map((image) => ImageRequestModel(
              image: image.image,
            ))
        .toList();

    await _imageDataSource.saveImage(imagesModel: imagesModel);
  }

  @override
  Future<void> deleteImage({required String id}) async {
    await _imageDataSource.deleteImage(id: id);
  }
}
