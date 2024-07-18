part of 'list_images_bloc.dart';

@immutable
sealed class ListImagesEvent {}

final class ListImagesSaved extends ListImagesEvent {
  final int page;
  ListImagesSaved({this.page = 0});
}
