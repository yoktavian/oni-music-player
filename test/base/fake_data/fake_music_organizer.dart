import 'package:flutter/widgets.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';

class FakeMusicOrganizer extends OniMusicOrganizer {
  ValueChanged<OniMusicState>? onStateChanged;

  OniMusicState state = OniMusicState.stop;

  @override
  void disposed() {}

  @override
  bool get isPaused => OniMusicState.pause == state;

  @override
  bool get isPlaying => OniMusicState.playing == state;

  @override
  bool get isStopped => OniMusicState.stop == state;

  @override
  void listenState(ValueChanged<OniMusicState> onStateChanged) {
    this.onStateChanged = onStateChanged;
  }

  @override
  void pause() {
    state = OniMusicState.pause;
    onStateChanged?.call(state);
  }

  @override
  void play(String url) {
    state = OniMusicState.playing;
    onStateChanged?.call(state);
  }

  @override
  void resume() {
    state = OniMusicState.resume;
    onStateChanged?.call(state);
  }

  @override
  void stop() {
    state = OniMusicState.stop;
    onStateChanged?.call(state);
  }
}
