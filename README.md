# soundpool

> This is a modified version of the code from https://github.com/ukasz123/soundpool/tree/master/soundpool, updated to be compatible with the latest Flutter version.

A Flutter Sound Pool for playing short media files.

**Sound Pool caches audio tracks in memory.**
This can be useful in following scenarios:

- lower latency between play signal and actual playing of the sound (audio does not need to be read from disc/web),
- the same sound may be used multiple times.

Inspired by [Android SoundPool API](https://developer.android.com/reference/android/media/SoundPool). This also means that multiple optional features are supported on **Android only**.

Example:

```dart
    import 'package:soundpool/soundpool.dart';

    Soundpool pool = Soundpool.fromOptions(
                      options: const SoundpoolOptions(streamType: StreamType.notification),
                  );

    int soundId = await rootBundle.load("sounds/dices.m4a").then((ByteData soundData) {
                  return pool.load(soundData);
                });
    int streamId = await pool.play(soundId);
```

### DOs and DON'Ts

- **DO NOT** create the `Soundpool` instance multiple times; **DO** create a `Soundpool` for logically connected sounds (ex. sounds for level, sounds with the same `streamType`),
- **DO NOT** load the same file multiple times; **DO** load it once (ideally while the application is starting), store sound id and use `play(soundId)`,
- **DO NOT** leave sounds loaded in memory when no longer used; **DO** call `release()` or `dispose()` when sounds are no longer useful,
  > You should call `release()` when you are sure you won't need loaded sounds anymore. The example would be Soundpool holding sounds for some level of the game. When players finishes it and moves to the next one you may release that `Soundpool` and create new one.\
  > On the other hand you may have another `Soundpool` holding sounds for UI actions feedback. That instance would be created at the start of the game and kept forever although it may be a good idea to load sounds when the game is resumed (being moved to the foreground) and release them when it is paused or stopped (see [WidgetsBindingObserver](https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver/didChangeAppLifecycleState.html)).
- **DO NOT** play music files; **DO** use plugin that is intended for that.
