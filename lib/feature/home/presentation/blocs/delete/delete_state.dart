part of 'delete_bloc.dart';

@immutable
sealed class DeleteState {}

final class DeleteInitial extends DeleteState {}

final class DeleteInProgress extends DeleteState {}

final class DeleteSuccess extends DeleteState {}

final class DeleteFailure extends DeleteState {
  final String message;
  DeleteFailure({required this.message});
}
