import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';


class ProfessionalScreen extends StatefulWidget {
  const ProfessionalScreen({super.key});

  @override
  State<ProfessionalScreen> createState() => _ProfessionalScreenState();
}

class _ProfessionalScreenState extends State<ProfessionalScreen> {
  // late FlickManager flickManager_two;

  File? video;
  FlickManager? flickManager;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager!.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
               
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
           
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    // AspectRatio(
                    //   aspectRatio: flickManager!.flickVideoManager!
                    //       .videoPlayerController!.value.aspectRatio, //16 / 10,
                    //   child: Container(
                    //     child: Center(
                    //       child: FlickVideoPlayer(flickManager: flickManager!),
                    //     ),
                    //   ),
                    // ),
                    video != null
                        ? Container(
                            child: Center(
                              child: FlickVideoPlayer(
                                  flickManager: FlickManager(
                                      videoPlayerController:
                                          VideoPlayerController.file(video!)
                                            ..initialize().then((_) {}))),
                            ),
                          )
                        : Text(
                            'no video select ',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                    TextButton(
                        onPressed: () async{
                          setState(() {
                              getVideoFile();
                              // _secondsStrToMilliseconds(secondsStr)
                              
                            }
                            );
                                                        //  await getDuration(video!);

                        },
                        child: Text(
                          'upload your video',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  getVideoFile() async {
    final FilePickerResult? picker = await FilePicker.platform
        .pickFiles(type: FileType.video, withReadStream: true);
    if (picker != null) {
      for (var element in picker.files) {
        print(element.path);

        setState(() {
          video = File(element.path!);
        });
      }
    }
  }
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
