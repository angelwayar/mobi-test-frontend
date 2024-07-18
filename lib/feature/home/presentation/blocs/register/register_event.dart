part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterImageSaved extends RegisterEvent {
  final List<XFile> image;
  RegisterImageSaved({required this.image});
}
