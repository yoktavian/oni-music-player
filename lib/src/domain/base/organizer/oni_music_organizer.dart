import 'package:flutter/cupertino.dart';

/// all of the states of oni music organizer
enum OniMusicState { playing, stop, pause, resume, completed }

/// just a wrapper for 3rd party library, so we can depend on this abstraction
/// class for the music organizer instead of depend to the 3rd party library
/// directly. Just in case perhaps in the future we have to change the library
/// for any reason so we can still using the same abstract class without any
/// changes in presentation layer and the changes is should be done in the
/// class implementation only.
abstract class OniMusicOrganizer<S> {
  // /// for state listener like playing, pause, stop, etc.
  // final ValueChanged<OniMusicState> onStateChanged;

  OniMusicOrganizer() {
    // listenState();
  }

  /// to play the music by url
  void play(String url);

  /// to stop current music playing on specific position
  void pause();

  /// to play current music on the latest position
  void resume();

  /// to stop and reset the position from the beginning.
  void stop();

  bool get isPlaying;

  bool get isPaused;

  bool get isStopped;

  void disposed();

  void listenState(ValueChanged<OniMusicState> onStateChanged);
}
