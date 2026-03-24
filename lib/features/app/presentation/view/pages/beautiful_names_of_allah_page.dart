import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_back_button_widget.dart';
import 'package:test_app/core/services/dependency_injection.dart';
import 'package:test_app/core/widgets/custom_scaffold.dart';
import 'package:test_app/features/app/domain/entities/allah_name.dart';
import 'package:test_app/features/app/presentation/controller/cubit/allah_names_cubit.dart';
import 'package:test_app/features/app/presentation/view/components/allah_name_widget.dart';

class BeautifulNamesOfAllahPage extends StatefulWidget {
  const BeautifulNamesOfAllahPage({super.key, required this.names});

  final List<AllahNameEntity> names;

  @override
  State<BeautifulNamesOfAllahPage> createState() =>
      _BeautifulNamesOfAllahPageState();
}

class _BeautifulNamesOfAllahPageState extends State<BeautifulNamesOfAllahPage> {
  List<AllahNameEntity> filteredNames = [];
  String query = "";

  @override
  void initState() {
    super.initState();
    filteredNames = widget.names;
  }

  void updateSearch(String value) {
    setState(() {
      query = value;
      filteredNames = widget.names
          .where((name) =>
              name.name.contains(query) ||
              name.transliteration
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              name.meaning.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllahNamesCubit>(
      create: (_) => sl<AllahNamesCubit>(),
      child: CustomScaffold(
        appBar: AppBar(
          leading: const GetAdaptiveBackButtonWidget(),
          title: const Text(
            'أسماء الله الحسنى',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: _AllahNamesSearch(names: widget.names),
                );
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      text: "تأمل في\n",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "جمال الصفات الإلهية",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// List of names
            Expanded(
              child: _ListViewOfNames(list: filteredNames),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListViewOfNames extends StatelessWidget {
  const _ListViewOfNames({
    required this.list,
  });

  final List<AllahNameEntity> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: list.length,
      padding: const EdgeInsets.all(8.0),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return AllahNameWidget(entity: list[index], index: index);
      },
    );
  }
}

/// Search
class _AllahNamesSearch extends SearchDelegate<AllahNameEntity?> {
  final List<AllahNameEntity> names;

  _AllahNamesSearch({required this.names});

  @override
  String get searchFieldLabel => 'ابحث عن اسم الله';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<AllahNameEntity> results = names
        .where((name) =>
            name.name.contains(query) ||
            name.transliteration.toLowerCase().contains(query.toLowerCase()) ||
            name.meaning.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _ListViewOfNames(list: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = names
        .where((name) =>
            name.name.contains(query) ||
            name.transliteration.toLowerCase().contains(query.toLowerCase()) ||
            name.meaning.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final name = suggestions[index];
        return ListTile(
          title: Text(name.name),
          subtitle: Text(name.transliteration),
          trailing: Text(name.meaning),
          onTap: () {
            query = name.name;
            showResults(context);
          },
        );
      },
    );
  }
}
