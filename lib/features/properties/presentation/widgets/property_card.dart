import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/app_button_styles.dart';
import '../../../../config/app_radii.dart';
import '../../../../config/app_spacing.dart';
import '../../../../config/app_text_styles.dart';
import '../../domain/entities/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  void _openInMaps() async {
    final lat = property.latLong.latitude;
    final lng = property.latLong.longitude;

    final uri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {}
  }

  void _showSnackBar(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
  }

  void _onAccept(BuildContext context) {
    _showSnackBar(
      context,
      message: 'Property is Accepted',
      backgroundColor: Colors.green,
    );
  }

  void _onReject(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reject property'),
          content: const Text('Do you want to reject this property?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _showSnackBar(
                  context,
                  message: 'Property is Rejected',
                  backgroundColor: Colors.red,
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openInMaps,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.cardVertical,
        ),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadii.card),
          border: Border.all(
            color: Colors.grey.withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PropertyHeader(property: property),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${property.homeType} · ${property.homeStatus}',
              style: AppTextStyles.statusSuccess,
            ),
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Beds: ${property.beds}',
              style: AppTextStyles.label,
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Text(
                  'Price: ',
                  style: AppTextStyles.label,
                ),
                Text(
                  property.price,
                  style: AppTextStyles.priceValue,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    '${property.address.street}, ${property.address.city}, ${property.address.state}',
                    style: AppTextStyles.location,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _onAccept(context),
                    style: AppButtonStyles.acceptOutlined,
                    child: const Text(
                      'Accept',
                      style: AppTextStyles.primaryAction,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _onReject(context),
                    style: AppButtonStyles.rejectOutlined,
                    child: const Text(
                      'Reject',
                      style: AppTextStyles.destructiveAction,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyHeader extends StatelessWidget {
  final Property property;

  const _PropertyHeader({required this.property});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(property.statusText);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Property ID: #${property.id}',
          style: AppTextStyles.cardTitle,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(AppRadii.chip),
            ),
            child: Text(
              property.statusText,
              style: AppTextStyles.chip.copyWith(color: statusColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'replacement':
        return const Color(0xFFFFA000);
      case 'renewal':
        return const Color(0xFF1976D2);
      case 'grace period':
        return const Color(0xFF2E7D32);
      default:
        return Colors.grey.shade700;
    }
  }
}
