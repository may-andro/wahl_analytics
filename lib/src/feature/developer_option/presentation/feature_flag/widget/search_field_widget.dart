import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/bloc.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureFlagBloc, FeatureFlagState>(
      buildWhen: (previous, current) =>
          current.isSearchFieldVisible != previous.isSearchFieldVisible,
      builder: (context, state) {
        if (!state.isSearchFieldVisible) return const SizedBox.shrink();

        return ListTile(
          title: TextField(
            focusNode: state.searchFocusNode,
            controller: state.searchTextEditingController,
            decoration: const InputDecoration(
              labelText: 'Feature toggle filter',
              hintText: 'Search term, e.g. "native", or "price"',
            ),
            onChanged: (value) {
              context.bloc.add(OnSearchTermUpdateEvent(value));
            },
          ),
        );
      },
    );
  }
}
