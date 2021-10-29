import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users_flutter/presentation/bloc/search_users_bloc.dart';
import 'package:github_users_flutter/presentation/pages/search/search_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      home: Scaffold(
        appBar: AppBar(title: const Text('Github Search')),
        body: BlocProvider(
          create: (_) => sl<SearchUsersBloc>(),
          child: const SearchUsersPage(),
        ),
      ),
    );
  }
}