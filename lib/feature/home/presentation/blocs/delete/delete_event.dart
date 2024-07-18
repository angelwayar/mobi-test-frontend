part of 'delete_bloc.dart';

@immutable
sealed class DeleteEvent {}

final class DeleteImageSaved extends DeleteEvent {
  final String id;
  DeleteImageSaved({required this.id});
}
