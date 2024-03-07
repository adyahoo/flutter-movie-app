import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_color.dart';

enum MovieButtonType { filled, outline, text }

enum MovieButtonSize { small, normal }

class MovieButton extends StatelessWidget {
  MovieButton.filled({
    super.key,
    required this.text,
    required this.isLoading,
    this.size = MovieButtonSize.normal,
    this.onPress,
    this.icon,
  })  : type = MovieButtonType.filled,
        textColor = Colors.white,
        bgColor = SecondaryColor.main,
        disabledTextColor = NeutralColor.neutral10,
        disabledBgColor = NeutralColor.neutral50,
        borderColor = null;

  MovieButton.outline({
    super.key,
    required this.text,
    required this.isLoading,
    this.size = MovieButtonSize.normal,
    this.onPress,
    this.icon,
  })  : type = MovieButtonType.outline,
        textColor = SecondaryColor.main,
        bgColor = null,
        disabledTextColor = NeutralColor.neutral50,
        disabledBgColor = null,
        borderColor = SecondaryColor.main;

  MovieButton.text({
    super.key,
    required this.text,
    required this.isLoading,
    this.size = MovieButtonSize.normal,
    this.onPress,
    this.icon,
  })  : type = MovieButtonType.text,
        textColor = SecondaryColor.main,
        bgColor = null,
        disabledTextColor = NeutralColor.neutral70,
        disabledBgColor = NeutralColor.neutral40,
        borderColor = null;

  final String text;
  final MovieButtonSize size;
  final bool isLoading;
  final void Function()? onPress;
  final IconData? icon;

  final MovieButtonType type;
  final Color textColor;
  final Color? bgColor;
  final Color disabledTextColor;
  final Color? disabledBgColor;
  final Color? borderColor;

  RoundedRectangleBorder get shape => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: (type == MovieButtonType.outline) ? BorderSide(color: (onPress != null) ? SecondaryColor.main : NeutralColor.neutral50, width: 1) : BorderSide.none,
      );

  EdgeInsetsGeometry get padding => (size == MovieButtonSize.normal) ? const EdgeInsets.symmetric(vertical: 12, horizontal: 32) : const EdgeInsets.symmetric(vertical: 12, horizontal: 32);

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
        child: const CircularProgressIndicator(
          color: Colors.white,
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
      onPressed: onPress,
      child: _buildContent(),
    );
  }
}
