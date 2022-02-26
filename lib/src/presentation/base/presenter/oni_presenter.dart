import 'package:flutter/widgets.dart';

abstract class OniPresenter<S, E> {
  final ValueNotifier<S> state;

  OniPresenter(this.state);

  /// all event triggered from the screen should be emitted to the
  /// presenter and the event will be mapped to change the state
  /// and will be broadcast to the screen.
  void emit(E event) {
    mapEvent(event);
  }

  /// map all related event that provided by screen.
  /// map event will be called once you emitting event
  /// from the screen.
  void mapEvent(E event);

  /// when you need to disposed something in the presenter you can
  /// override this on the implementation class. but be carefully, don't
  /// forget to call super.dispose() because as you now on this architecture
  /// our state is using value notifier, which mean the state have to be disposed
  /// as well once the screen disposed.
  void dispose() {
    state.dispose();
  }
}
