import 'package:flutter/material.dart';
import 'package:oni_music_player/src/presentation/base/router/oni_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          child: Text('data'),
          onTap: () {
            OniRouter.pushName(
              context,
              '/product_detail/song',
            );
          },
        ),
      ),
    );
  }
}
