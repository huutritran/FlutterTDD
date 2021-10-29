import 'package:get_it/get_it.dart';
import 'package:github_users_flutter/core/flatform/network_info.dart';
import 'package:github_users_flutter/data/datasources/github_user_remote_data_source.dart';
import 'package:github_users_flutter/data/repositories/github_user_repository_impl.dart';
import 'package:github_users_flutter/domain/repositories/github_user_repository.dart';
import 'package:github_users_flutter/domain/usecases/get_user_detail.dart';
import 'package:github_users_flutter/domain/usecases/search_users.dart';
import 'package:github_users_flutter/presentation/bloc/search_users_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => SearchUsersBloc(searchUsers: sl()));

  // Use cases
  sl.registerLazySingleton(() => SearchUsers(sl()));
  sl.registerLazySingleton(() => GetUserDetail(sl()));

  // Repository
  sl.registerLazySingleton<GitHubUserRepository>(
    () => GitHubUserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  //Data source
  sl.registerLazySingleton<GithubRemoteDataSource>(
    () => GitHubRemoteDataSourceImpl(sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: sl()),
  );

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
