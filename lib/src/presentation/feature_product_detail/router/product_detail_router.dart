import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/presentation/base/router/oni_router.dart';
import 'package:oni_music_player/src/presentation/feature_product_detail/page/song_detail.dart';

class ProductDetailRouter extends OniRouter {
  @override
  Map<String, WidgetBuilder> get routes => {
    '/product_detail/song': (context) => SongDetail(),
  };
}