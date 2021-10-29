part of 'search_users_bloc.dart';

abstract class SearchUsersState extends Equatable {
  const SearchUsersState();

  @override
  List<Object?> get props => [];
}

class SearchEmpty extends SearchUsersState {}

class SearchLoading extends SearchUsersState {}

class SearchSuccess extends SearchUsersState {
  final List<User> items;

  const SearchSuccess({required this.items});

  @override
  List<Object?> get props => items;

  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

class SearchError extends SearchUsersState {
  final String error;

  const SearchError({required this.error});

  @override
  List<Object> get props => [error];
}
