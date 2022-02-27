import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/core/service/service_factory.dart';
import 'package:oni_music_player/src/core/service/service_locator.dart';

class ServiceLocatorImpl extends ServiceLocator {
  @override
  void registerFactory<T extends Object>(ValueGetter<T> factory) {
    if (serviceContainer[T] != null) return;
    serviceContainer[T] = ServiceFactory(factory);
  }

  @override
  T getIt<T>() {
    final container = serviceContainer[T];
    if (container != null) return container.object() as T;

    throw ('$T is not registered yet in the service locator');
  }

  @override
  void clear() {
    serviceContainer.clear();
  }
}
