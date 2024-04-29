import 'package:flutter/material.dart';
import 'package:movie_app/config/app_color.dart';

enum MovieButtonType { filled, outline, text }

enum MovieButtonSize { small, normal }

enum MovieButtonVariant { blue, gray }

class MovieButton extends StatelessWidget {
  MovieButton.filled({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPress,
    this.size = MovieButtonSize.normal,
    this.variant = MovieButtonVariant.blue,
    this.icon,
  })  : type = MovieButtonType.filled,
        bgColor = SecondaryColor.main,
        disabledTextColor = NeutralColor.neutral10,
        disabledBgColor = NeutralColor.neutral50,
        borderColor = SecondaryColor.main;

  MovieButton.outline({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPress,
    this.size = MovieButtonSize.normal,
    this.variant = MovieButtonVariant.blue,
    this.icon,
  })  : type = MovieButtonType.outline,
        bgColor = null,
        disabledTextColor = NeutralColor.neutral50,
        disabledBgColor = null,
        borderColor = SecondaryColor.main;

  MovieButton.text({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPress,
    this.size = MovieButtonSize.normal,
    this.variant = MovieButtonVariant.blue,
    this.icon,
  })  : type = MovieButtonType.text,
        bgColor = null,
        disabledTextColor = NeutralColor.neutral70,
        disabledBgColor = NeutralColor.neutral40,
        borderColor = Colors.white;

  final String text;
  final MovieButtonSize size;
  final bool isLoading;
  final void Function()? onPress;
  final IconData? icon;

  final MovieButtonType type;
  final Color? bgColor;
  final Color disabledTextColor;
  final Color? disabledBgColor;
  final Color borderColor;
  final MovieButtonVariant variant;

  Color getBorderColor() {
    if (variant == MovieButtonVariant.gray) {
      return TextColor.secondary;
    }

    return borderColor;
  }

  Color get textColor {
    if (type == MovieButtonType.filled) {
      return Colors.white;
    }

    if (variant == MovieButtonVariant.gray) {
      return TextColor.secondary;
    }

    return SecondaryColor.main;
  }

  RoundedRectangleBorder get shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: (type == MovieButtonType.outline) ? BorderSide(color: (onPress != null) ? getBorderColor() : NeutralColor.neutral50, width: 1) : BorderSide.none,
      );

  EdgeInsetsGeometry get padding => (size == MovieButtonSize.normal) ? const EdgeInsets.symmetric(vertical: 12, horizontal: 32) : const EdgeInsets.symmetric(vertical: 8, horizontal: 32);

  TextStyle getTextStyle(BuildContext context) => (size == MovieButtonSize.normal) ? Theme.of(context).textTheme.titleMedium! : Theme.of(context).textTheme.bodyMedium!;

  Widget _buildContent() {
    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: (onPress != null) ? textColor : disabledTextColor,
          ),
          const SizedBox(width: 4),
          Text(text)
        ],
      );
    }

    if (isLoading) {
      return SizedBox(
        width: (size == MovieButtonSize.normal) ? 22 : 16,
        height: (size == MovieButtonSize.normal) ? 22 : 16,
        child: CircularProgressIndicator(
          color: textColor,
        ),
      );
    }

    return Text(text);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: padding,
        shape: shape,
        textStyle: getTextStyle(context),
        minimumSize: const Size.fromHeight(16),
        backgroundColor: bgColor,
        foregroundColor: textColor,
        disabledBackgroundColor: disabledBgColor,
        disabledForegroundColor: disabledTextColor,
      ),
      onPressed: (isLoading) ? null : onPress,
      child: _buildContent(),
    );
  }
}
