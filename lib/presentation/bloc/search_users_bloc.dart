import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/domain/entities/user.dart';
import 'package:github_users_flutter/domain/usecases/search_users.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_users_event.dart';

part 'search_users_state.dart';

const networkError = "Check your connection and try again";
const serverError = "sorry we are having some temporary server issues";

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final SearchUsers searchUsers;

  SearchUsersBloc({required this.searchUsers}) : super(SearchEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  void _onTextChanged(
    TextChanged event,
    Emitter<SearchUsersState> emit,
  ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchEmpty());

    emit(SearchLoading());

    final searchParams = SearchUsersParam(searchTerm, 1);
    final resultEither = await searchUsers(searchParams);

    resultEither.fold((failure) {
      var errorMsg = serverError;
      if (failure is NetworkFailure) {
        errorMsg = networkError;
      }
      emit(SearchError(error: errorMsg));
    }, (result) {
      emit(SearchSuccess(items: result.users));
    });
  }
}
