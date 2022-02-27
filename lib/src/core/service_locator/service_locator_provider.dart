import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/core/service_locator/service_locator.dart';

class ServiceLocatorProvider extends InheritedWidget {
  final ServiceLocator _serviceLocator;

  const ServiceLocatorProvider({
    Key? key,
    required ServiceLocator serviceLocator,
    required Widget child,
  })  : _serviceLocator = serviceLocator,
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static ServiceLocator of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ServiceLocatorProvider>();

    if (provider == null) {
      throw ('$provider has not been initialized');
    }

    final serviceLocator = provider._serviceLocator;
    return serviceLocator;
  }
}
