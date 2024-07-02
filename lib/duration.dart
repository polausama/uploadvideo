import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';

class VideoFileDurationService {
  // const VideoFileDurationService._();

  static Future<Duration> getDuration(File file) async {
    final data = await FFprobeKit.getMediaInformation(file.path);
    final media = data.getMediaInformation();
    final secondsStr = media?.getDuration();

    final milliseconds = _secondsStrToMilliseconds(secondsStr);
    if (milliseconds == null) return Duration.zero;
    return Duration(milliseconds: milliseconds);
  }

  static int? _secondsStrToMilliseconds(String? secondsStr) {
    if (secondsStr == null) return null;
    final seconds = double.tryParse(secondsStr);
    if (seconds == null) return null;
    final milliseconds = (seconds * 1000).toInt();
    return milliseconds;
  }
}