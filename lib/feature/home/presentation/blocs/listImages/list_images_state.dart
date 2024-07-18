part of 'list_images_bloc.dart';

@immutable
sealed class ListImagesState {}

final class ListImagesInitial extends ListImagesState {}

final class ListImageInProgress extends ListImagesState {}

final class ListImageSuccess extends ListImagesState {
  final List<ImageResultEntity> images;
  ListImageSuccess({required this.images});
}

final class ListImageFailure extends ListImagesState {
  final String message;
  ListImageFailure({required this.message});
}
