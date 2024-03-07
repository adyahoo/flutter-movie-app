import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movie_app/app/ui/widgets/movie_menu_item.dart';
import 'package:movie_app/utils/dummies/MovieDummyData.dart';

import '../../../utils/app_color.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Widget _renderAppbar(BuildContext context) {
    var img = "asdfsd";

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: ShapeDecoration(
            image: DecorationImage(image: NetworkImage(img), fit: BoxFit.contain),
            shape: const CircleBorder(side: BorderSide(width: 2, color: Colors.white)),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          img,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _renderAppbar(context),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: PrimaryColor.main,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translate('manage_account'),
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: MovieDummyData.getAccountMenu().length,
                itemBuilder: (context, index) => MovieMenuItem(data: MovieDummyData.getAccountMenu()[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
