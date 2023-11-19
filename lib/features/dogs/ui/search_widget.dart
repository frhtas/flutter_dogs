import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/app_colors.dart';
import '../bloc/dogs_bloc.dart';

class SearchWidget extends StatefulWidget {
  final String filter;
  const SearchWidget({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    _searchController.text = widget.filter;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DogsBloc, DogsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.multiline,
          autofocus: true,
          controller: _searchController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              color: versionColor.withOpacity(0.6),
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            border: InputBorder.none,
          ),
          maxLines: null,
          onSubmitted: (value) {
            context.read<DogsBloc>().add(DogsBreedFilterEvent(filter: value));
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
