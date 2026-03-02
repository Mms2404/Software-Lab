import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:software_lab/core/constants/app_colors.dart';

enum NotificationType {
  success,
  error,
  warning,
  info,
}

class AppNotification {
  static void show(
    BuildContext context, {
    required String message,
    NotificationType type = NotificationType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _NotificationWidget(
        message: message,
        type: type,
        onDismiss: () => overlayEntry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(overlayEntry);
  }

  // Convenience methods for one-liner usage
  static void success(BuildContext context, String message) {
    show(context, message: message, type: NotificationType.success);
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, type: NotificationType.error);
  }

  static void warning(BuildContext context, String message) {
    show(context, message: message, type: NotificationType.warning);
  }

  static void info(BuildContext context, String message) {
    show(context, message: message, type: NotificationType.info);
  }
}

class _NotificationWidget extends StatefulWidget {
  final String message;
  final NotificationType type;
  final VoidCallback onDismiss;
  final Duration duration;

  const _NotificationWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: _buildNotificationBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationBar() {
  Color borderColor;
  Color bgColor;
  IconData iconData;
  Color iconColor;

  switch (widget.type) {
    case NotificationType.success:
      borderColor = AppColors.tertiary;
      bgColor = AppColors.tertiary.withOpacity(0.12);
      iconData = Icons.check_circle;
      iconColor = AppColors.tertiary;
      break;

    case NotificationType.error:
      borderColor = AppColors.primary;
      bgColor = AppColors.primary.withOpacity(0.12);
      iconData = Icons.error;
      iconColor = AppColors.primary;
      break;

    case NotificationType.warning:
      borderColor = AppColors.secondary;
      bgColor = AppColors.secondary.withOpacity(0.15);
      iconData = Icons.warning_amber_rounded;
      iconColor = AppColors.secondary;
      break;

    case NotificationType.info:
      borderColor = AppColors.primary;
      bgColor = AppColors.primary.withOpacity(0.08);
      iconData = Icons.info;
      iconColor = AppColors.primary;
      break;
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: borderColor,
        width: 1.2,
      ),
    ),
    child: Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            widget.message,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _controller.reverse().then((_) => widget.onDismiss());
          },
          child: Icon(
            Icons.close,
            color: AppColors.lightText,
            size: 18.sp,
          ),
        ),
      ],
    ),
  );
}
}
