import 'package:flutter/material.dart';
import 'package:movie_app/app/data/models/picker_model.dart';
import 'package:movie_app/utils/app_color.dart';

class MovieMenuItem extends StatelessWidget {
  const MovieMenuItem({super.key, required this.data});

  final PickerModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19555555),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            data.prefixIcon,
            size: 20,
            color: Colors.black,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              data.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: PrimaryColor.main),
            ),
          ),
          const SizedBox(width: 16),
          Icon(
            Icons.chevron_right_rounded,
            size: 16,
            color: PrimaryColor.main,
          )
        ],
      ),
    );
  }
}
