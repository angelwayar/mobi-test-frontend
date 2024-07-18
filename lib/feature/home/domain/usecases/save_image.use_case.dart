import '../entities/images.entity.dart';
import '../repositories/image.repository.dart';

class SaveImageUseCase {
  const SaveImageUseCase(this._imageRespository);

  final ImageRespository _imageRespository;

  Future<void> call({required List<ImageEntity> images}) async {
    _imageRespository.saveImage(images: images);
  }
}
