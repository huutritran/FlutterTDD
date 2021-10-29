part of 'search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class TextChanged extends SearchUsersEvent {
  final String text;

  const TextChanged({required this.text});

  @override
  List<Object?> get props => throw UnimplementedError();

  @override
  String toString() => 'TextChanged { text: $text }';
}
