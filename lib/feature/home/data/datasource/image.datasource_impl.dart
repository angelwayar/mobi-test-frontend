import 'package:dio/dio.dart';

import '../../../../core/service/http_dio.service.dart';
import '../models/image.model.dart';
import 'image.datasource.dart';

class ImageDataSourceImpl implements ImageDataSource {
  const ImageDataSourceImpl(this._dioClient);

  final DioClient _dioClient;
  static const String _basePath = '/api';

  @override
  Future<List<ImageResponseModel>> getAllImages({
    int page = 0,
    int limit = 0,
  }) async {
    final res = await _dioClient.get(path: '$_basePath/file/$page/$limit');
    final images = <ImageResponseModel>[];

    for (var img in res["data"]) {
      images.add(ImageResponseModel.fromJson(img));
    }

    return images;
  }

  @override
  Future<void> saveImage({
    required List<ImageRequestModel> imagesModel,
  }) async {
    await Future.wait(
      imagesModel.map((img) async {
        final data = await img.toJson();

        await _dioClient.post(
          path: '$_basePath/file',
          data: FormData.fromMap(data),
        );
      }),
    );
  }

  @override
  Future<void> deleteImage({required String id}) async {
    await _dioClient.delete(path: '$_basePath/file/$id');
  }
}
