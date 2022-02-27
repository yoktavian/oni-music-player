import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/core/service/service_locator.dart';

/// Service locator provider basically a widget that holding a service locator
/// that can be consume by all of the child widget. Service locator will be
/// on the top of widget tree, so all of descendant widget can consume service
/// locator by using ServiceLocatorProvider.of(context);
class ServiceLocatorProvider extends InheritedWidget {
  final ServiceLocator _serviceLocator;

  const ServiceLocatorProvider({
    Key? key,
    required ServiceLocator serviceLocator,
    required Widget child,
  })  : _serviceLocator = serviceLocator,
        super(child: child, key: key);

  /// we don't need to rebuild descendant widget if service locator is changed,
  /// so here we returning false.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  /// to get service locator from descendant widget.
  static ServiceLocator of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<ServiceLocatorProvider>();

    /// not trying to abuse throw, just to make sure the engineer aware if
    /// they are make a mistake.
    if (provider == null) {
      throw ('$provider has not been initialized');
    }

    final serviceLocator = provider._serviceLocator;
    return serviceLocator;
  }
}
