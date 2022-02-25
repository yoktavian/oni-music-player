import 'package:flutter/widgets.dart';

abstract class OniPresenter<S, E> {
  final ValueNotifier<S> state;

  OniPresenter(this.state);

  void emit(E event) {
    mapEvent(event);
  }

  void mapEvent(E event);
}