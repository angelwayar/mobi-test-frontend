import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_frontend/feature/home/domain/entities/images.entity.dart';
import 'package:test_frontend/feature/home/domain/repositories/image.repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._imageRespository) : super(RegisterInitial()) {
    on<RegisterImageSaved>(_onRegisterImageSaved);
  }

  final ImageRespository _imageRespository;

  Future<void> _onRegisterImageSaved(
    RegisterImageSaved event,
    Emitter emit,
  ) async {
    emit(RegisterInProgress());
    try {
      final List<ImageEntity> images = event.image
          .map(
            (e) => ImageEntity(image: e),
          )
          .toList();

      await _imageRespository.saveImage(images: images);

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(message: "Ocurrio un error"));
    }
  }
}
