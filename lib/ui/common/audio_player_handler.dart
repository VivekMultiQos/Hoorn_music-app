import 'dart:ffi';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';

class AudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  final AudioPlayer _player = LoginUser.instance.player;

  AudioPlayerHandler() {
    // Initial song setup
    _initializeSong(LoginUser.instance.currentSong);

    // Stream playback state and media item to the audio service
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    // Listen for song changes and update media item accordingly
    LoginUser.instance.currentPlayingSong.listen((value) {
      _updateCurrentSong(value);
    });
  }

  // Initialize the player with the initial song
  void _initializeSong(Songs song) {
    final item = _createMediaItem(song);
    mediaItem.add(item); // Add initial media item
    _player.setAudioSource(AudioSource.uri(Uri.parse(item.id)));
  }

  // Update the current song and its media item
  void _updateCurrentSong(Songs song) {
    final item = _createMediaItem(song);
    mediaItem.add(item); // Update media item only when needed
  }

  // Create MediaItem from song data
  MediaItem _createMediaItem(Songs song) {
    return MediaItem(
      id: song.downloadUrl?.last.url ?? '',
      album: song.album?.name,
      title: song.name ?? '',
      artist: song.artists?.primary?.first.name,
      duration: song.duration != null
          ? Duration(seconds: song.duration ?? 0)
          : Duration.zero,
      artUri: Uri.parse(song.image?.last.url ?? ''),
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> skipToNext() async {
    LoginUser.instance.playNext.value = true;
  }

  // Add previous song functionality
  @override
  Future<void> skipToPrevious() async {
    LoginUser.instance.playPrevious.value = true;
  }

  // Transform playback event to update playback state
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious, // Add previous button
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext, // Add next button
      ],
      systemActions: const {
        MediaAction.skipToPrevious, // Enable previous action
        MediaAction.play,
        MediaAction.pause,
        MediaAction.stop,
        MediaAction.skipToNext, // Enable next action
      },
      androidCompactActionIndices: const [0, 1, 3],
      // Indices for compact controls
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  @override
  Future<void> seek(Duration position) async {
    if (_player.playing) {
      await _player.seek(position);
    }
  }
}
