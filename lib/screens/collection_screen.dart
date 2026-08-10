import 'package:artexplorer/blocs/collection/collection_state.dart';
import 'package:artexplorer/theme/app_colors.dart';
import 'package:artexplorer/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/collection/collection_bloc.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        switch (state) {
          case CollectionError():
            debugPrint(state.error);
            return Scaffold(
              appBar: AppBar(title: Text(AppStrings.myCollection), actions: [
                ],
              ),
              body: Stack(children: [Text('error')]),
            );
          case CollectionLoading():
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                  strokeWidth: 8.0,
                ),
              ),
            );
          case CollectionLoaded():
            return Scaffold(
              appBar: AppBar(title: Text(AppStrings.myCollection)),
              body: Column(
                children: [Text(' ${state.artworks.length} works saved')],
              ),
            );
        }
      },
    );
  }
}
