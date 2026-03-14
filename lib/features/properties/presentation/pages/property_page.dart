import '../bloc/property_bloc.dart';
import '../bloc/property_event.dart';
import '../bloc/property_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_pagination_list/config/app_radii.dart';
import 'package:exam_pagination_list/config/app_colors.dart';
import 'package:exam_pagination_list/config/app_spacing.dart';
import 'package:exam_pagination_list/config/app_text_styles.dart';
import 'package:exam_pagination_list/features/properties/presentation/widgets/property_card.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  final ScrollController _scrollController = ScrollController();
  bool _toggleValue = true;

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
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: AppSpacing.screenHorizontal,
        title: Row(
          children: [
            const Text(
              'Welcome, Prince Company',
              style: AppTextStyles.greeting,
            ),
            const SizedBox(width: AppSpacing.xxs),
            Transform.scale(
              scale: 0.9,
              child: Switch(
                value: _toggleValue,
                onChanged: (v) => setState(() => _toggleValue = v),
                activeTrackColor: AppColors.appBarAccentGreen,
                thumbColor: WidgetStateProperty.all(Colors.white),
              ),
            ),
          ],
        ),
        actions: [
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.screenHorizontal),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  color: AppColors.appBarIconCircle,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () {},
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 44,
                      height: 44,
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.appBarAccentGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: const Text(
                      '99+',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<PropertyBloc, PropertyState>(
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
                  padding: const EdgeInsets.only(
                    left: AppSpacing.screenHorizontal,
                    right: AppSpacing.screenHorizontal,
                    top: 10,
                    bottom: AppSpacing.screenHorizontal,
                  ),
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

                    return PropertyCard(property: property, index: index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
