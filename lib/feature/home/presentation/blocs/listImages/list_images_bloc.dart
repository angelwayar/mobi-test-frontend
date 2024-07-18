import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../domain/entities/images.entity.dart';
import '../../../domain/repositories/image.repository.dart';

part 'list_images_event.dart';
part 'list_images_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListImagesBloc extends Bloc<ListImagesEvent, ListImagesState> {
  ListImagesBloc(this._imageRespository) : super(ListImageInProgress()) {
    on<ListImagesSaved>(
      _onListImagesSaved,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  final ImageRespository _imageRespository;

  Future<void> _onListImagesSaved(ListImagesSaved event, Emitter emit) async {
    emit(ListImageInProgress());
    try {
      final images = await _imageRespository.getAllImage();

      emit(ListImageSuccess(images: images));
    } catch (e) {
      emit(ListImageFailure(message: "Ocurrio un error"));
    }
  }
}
