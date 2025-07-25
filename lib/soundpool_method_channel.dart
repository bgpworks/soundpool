import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'soundpool_platform_interface.dart';

/// An implementation of [SoundpoolPlatform] that uses method channels.
class MethodChannelSoundpool extends SoundpoolPlatform {
  /// The method channel used to interact with the native platform.
  final _channel = const MethodChannel('soundpool');

  @override
  Future<int> init(
    int streamType,
    int maxStreams,
    Map<String, dynamic> platformOptions,
  ) async => (await _channel.invokeMethod(
    "initSoundpool",
    <String, dynamic>{"maxStreams": maxStreams, "streamType": streamType}
      ..addAll(platformOptions),
  ))!;

  @override
  Future<int> loadUri(int poolId, String uri, int priority) async =>
      (await _channel.invokeMethod("loadUri", {
        "poolId": poolId,
        "uri": uri,
        "priority": priority,
      }))!;

  @override
  Future<int> loadUint8List(
    int poolId,
    Uint8List rawSound,
    int priority,
  ) async => (await _channel.invokeMethod("load", {
    "poolId": poolId,
    "rawSound": rawSound,
    "priority": priority,
  }))!;

  @override
  Future<int> play(int poolId, int soundId, int repeat, double rate) async =>
      (await _channel.invokeMethod("play", {
        "poolId": poolId,
        "soundId": soundId,
        "repeat": repeat,
        "rate": rate,
      }))!;

  @override
  Future<void> stop(int poolId, int streamId) =>
      _channel.invokeMethod("stop", {"poolId": poolId, "streamId": streamId});

  @override
  Future<void> pause(int poolId, int streamId) =>
      _channel.invokeMethod("pause", {"poolId": poolId, "streamId": streamId});

  @override
  Future<void> resume(int poolId, int streamId) =>
      _channel.invokeMethod("resume", {"poolId": poolId, "streamId": streamId});

  @override
  Future<void> setVolume(
    int poolId,
    int? soundId,
    int? streamId,
    double? volumeLeft,
    double? volumeRight,
  ) => _channel.invokeMethod("setVolume", {
    "poolId": poolId,
    "soundId": soundId,
    "streamId": streamId,
    "volumeLeft": volumeLeft,
    "volumeRight": volumeRight,
  });

  @override
  Future<void> setRate(int poolId, int streamId, double playbackRate) =>
      _channel.invokeMethod("setRate", {
        "poolId": poolId,
        "streamId": streamId,
        "rate": playbackRate,
      });

  @override
  Future<void> dispose(int poolId) =>
      _channel.invokeMethod("dispose", {"poolId": poolId});

  @override
  Future<void> release(int poolId) =>
      _channel.invokeMethod("release", {"poolId": poolId});
}
