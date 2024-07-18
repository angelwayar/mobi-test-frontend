import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repositories/image.repository.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc(this._imageRespository) : super(DeleteInitial()) {
    on<DeleteImageSaved>(_onDeleteImageSaved);
  }
  final ImageRespository _imageRespository;

  Future<void> _onDeleteImageSaved(event, emit) async {
    emit(DeleteInProgress());
    try {
      
      await _imageRespository.deleteImage(id: event.id);

      emit(DeleteSuccess());
    } catch (e) {
      emit(DeleteFailure(message: "Ocurrio un error"));
    }
  }
}
