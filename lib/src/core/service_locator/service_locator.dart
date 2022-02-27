import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/core/service_locator/service_factory.dart';

abstract class ServiceLocator {
  final Map<Type, ServiceFactory> serviceContainer = {};

  void registerFactory<T extends Object>(ValueGetter<T> factory);

  T getIt<T>();

  void clear();
}
