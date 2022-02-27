import 'package:flutter/widgets.dart';
import 'package:oni_service_locator/src/oni_service_factory.dart';

/// Service locator is a simple dependency injection to make all of layer
/// loose coupled. By using dependency injection, if the implementation class
/// of an abstract class has been changed and this is being used in some screens
/// then some day the implementation class is changed, so you don't have to
/// replace it one by one in every screen, you just need to replace at one
/// place that is in the dependency injection registrar.
abstract class OniServiceLocator {
  final Map<Type, OniServiceFactory> serviceContainer = {};

  /// to register all of classes that need to be injected.
  void registerFactory<T extends Object>(ValueGetter<T> factory);

  /// to get an object that already registered in the service locator.
  /// if the object is not registered yet, then it will trigger an exception.
  T getIt<T>();

  /// clear all data from service locator, so please make sure you do it once
  /// the service locator not being used anymore.
  void clear();
}
