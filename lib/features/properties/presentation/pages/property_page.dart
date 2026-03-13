import 'package:exam_pagination_list/config/app_constants.dart';
import 'package:exam_pagination_list/features/properties/presentation/widgets/property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/property_bloc.dart';
import '../bloc/property_event.dart';
import '../bloc/property_state.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<PropertyBloc>().add(FetchProperties());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PropertyBloc>().add(LoadMoreProperties());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
      ),
      body: BlocBuilder<PropertyBloc, PropertyState>(
        builder: (context, state) {
          if (state.isLoading && state.properties.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.properties.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.error!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PropertyBloc>().add(FetchProperties());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!state.isLoading &&
              state.properties.isEmpty &&
              state.error == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'No properties found.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PropertyBloc>().add(FetchProperties());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.properties.length
                : state.properties.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.properties.length) {
                if (state.hasReachedMax) {
                  return const SizedBox.shrink();
                }

                if (state.isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state.error != null) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.error!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<PropertyBloc>()
                                .add(LoadMoreProperties());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              }

              final property = state.properties[index];

              return PropertyCard(property: property);
            },
          );
        },
      ),
    );
  }
}
