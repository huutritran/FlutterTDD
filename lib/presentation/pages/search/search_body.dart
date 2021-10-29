import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users_flutter/domain/entities/user.dart';
import 'package:github_users_flutter/presentation/bloc/search_users_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsersBloc, SearchUsersState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SearchError) {
          return Text(state.error);
        }
        if (state is SearchSuccess) {
          return state.items.isEmpty
              ? const Text('No Results')
              : Expanded(child: UserItem(items: state.items));
        }
        return const Text('Please enter a term to begin');
      },
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.items}) : super(key: key);

  final List<User> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  const _SearchResultItem({Key? key, required this.item}) : super(key: key);

  final User item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network(item.avatarUrl),
      ),
      title: Text(item.name),
      onTap: () async {
        if (await canLaunch(item.html)) {
          await launch(item.html);
        }
      },
    );
  }
}