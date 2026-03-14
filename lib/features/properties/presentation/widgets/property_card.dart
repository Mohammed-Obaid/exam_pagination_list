import 'package:flutter/material.dart';
import '../../../../config/app_radii.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_spacing.dart';
import '../../domain/entities/property.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/app_text_styles.dart';
import '../../../../config/app_button_styles.dart';

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
      backgroundColor: AppColors.primaryGreen,
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
                  backgroundColor: AppColors.rejectRed,
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  String get _daysOnZillowText {
    final days = property.daysOnZillow;
    return '$days ${days == 1 ? 'day' : 'days'}';
  }

  /// Converts raw homeStatus (e.g. FOR_SALE) to display text (e.g. For Sale).
  static String _formatHomeStatus(String raw) {
    if (raw.isEmpty) return raw;
    return raw
        .split('_')
        .map((w) =>
            w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final homeStatus = property.homeStatus;
    final homeStatusDisplay = _formatHomeStatus(homeStatus);
    final chipStyle = _statusChipStyle(homeStatus);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.cardVertical),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppRadii.card),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Booking ID: ',
                  style: AppTextStyles.cardTitle.copyWith(
                    color: AppColors.bookingIdLabel,
                    // fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: '#${property.id ?? "—"}',
                      style: AppTextStyles.cardTitle.copyWith(
                        color: AppColors.bookingIdValue,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: chipStyle.bg,
                  borderRadius: BorderRadius.circular(AppRadii.chip),
                ),
                child: Text(
                  homeStatusDisplay,
                  style: AppTextStyles.chip.copyWith(color: chipStyle.text),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            _daysOnZillowText,
            style: AppTextStyles.dateTime,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.dividerColor, height: 1, thickness: 1),
          const SizedBox(height: AppSpacing.sm),
          _buildStatusBody(homeStatusDisplay),
          const SizedBox(height: AppSpacing.sm),
          GestureDetector(
            onTap: _openInMaps,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    '${property.address.street}, ${property.address.city}, ${property.address.state} - ${property.address.zipcode}',
                    style: AppTextStyles.location,
                  ),
                ),
              ],
            ),
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
              const SizedBox(width: AppSpacing.sm),
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
    );
  }

  Widget _buildStatusBody(String displayStatus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address: ',
              style: AppTextStyles.cardTitle.copyWith(
                color: AppColors.bookingIdLabel,
                // fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Text(
                '${property.address}',
                style: AppTextStyles.cardTitle.copyWith(
                  color: AppColors.bookingIdValue,
                  // fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Text(
              'Price: ',
              style: AppTextStyles.cardTitle.copyWith(
                color: AppColors.bookingIdLabel,
              ),
            ),
            Text(
              '${property.price}',
              style: AppTextStyles.dateTime,
            ),
          ],
        ),
      ],
    );
  }

  ({Color bg, Color text}) _statusChipStyle(String homeStatus) {
    switch (homeStatus) {
      case 'FOR_SALE':
        return (
          bg: AppColors.replacementChipBg,
          text: AppColors.replacementChipText
        );
      case 'Coming soon':
        return (
          bg: AppColors.gracePeriodChipBg,
          text: AppColors.gracePeriodChipText
        );
      default:
        return (bg: AppColors.renewalChipBg, text: AppColors.renewalChipText);
    }
  }
}
