import 'package:flutter/cupertino.dart';

enum OniMusicState { playing, stop, pause, resume, completed }

abstract class OniMusicOrganizer<S> {
  final ValueChanged<OniMusicState> onStateChanged;

  OniMusicOrganizer(this.onStateChanged) {
    listenState();
  }

  void play(String url);

  void pause();

  void resume();

  void stop();

  bool get isPlaying;

  bool get isPaused;

  bool get isStopped;

  void disposed();

  void listenState();
}
