import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:oni_music_player/src/domain/base/organizer/oni_music_organizer.dart';

class OniMusicOrganizerImpl extends OniMusicOrganizer {
  final AudioPlayer player;

  OniMusicOrganizerImpl({
    AudioPlayer? audioPlayer,
  })  : player = audioPlayer ?? AudioPlayer(),
        super();

  @override
  void pause() {
    player.pause();
  }

  @override
  void play(String url) {
    player.play(url);
  }

  @override
  void resume() {
    player.resume();
  }

  @override
  void stop() {
    player.stop();
  }

  @override
  get isPlaying => player.state == PlayerState.PLAYING;

  @override
  get isPaused => player.state == PlayerState.PAUSED;

  @override
  get isStopped => player.state == PlayerState.STOPPED;

  @override
  void disposed() {
    player.dispose();
  }

  @override
  void listenState(ValueChanged<OniMusicState> onStateChanged) {
    player.onPlayerStateChanged.listen(
      (state) {
        switch (state) {
          case PlayerState.PLAYING:
            onStateChanged(OniMusicState.playing);
            break;
          case PlayerState.PAUSED:
            onStateChanged(OniMusicState.pause);
            break;
          case PlayerState.STOPPED:
            onStateChanged(OniMusicState.stop);
            break;
          case PlayerState.COMPLETED:
            onStateChanged(OniMusicState.completed);
            break;
          default:
            throw Exception('Error, $state is unknown state');
        }
      },
    );
  }
}
