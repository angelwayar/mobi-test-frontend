import '../entities/images.entity.dart';
import '../repositories/image.repository.dart';

class GetAllImageUseCase {
  const GetAllImageUseCase(this._imageRespository);

  final ImageRespository _imageRespository;

  Future<List<ImageResultEntity>> call() async {
    return await _imageRespository.getAllImage();
  }
}
