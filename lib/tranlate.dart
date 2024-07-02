import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/upload.dart';
import 'package:video_player/video_player.dart';

class Translate extends StatefulWidget {
  const Translate({super.key});

  @override
  State<Translate> createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
File? video;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                  
                ),
                width: double.infinity,
                child:  Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Translate the video to sign language',
                        style: TextStyle(
                          color: Color(0xFF6FA1A2),
                          fontSize: 17,
                          fontWeight:FontWeight.w700 
                        ),
                      ),
                   Container(
                    child: Center(
                                child: FlickVideoPlayer(
                                    flickManager: FlickManager(
                                        videoPlayerController:
                                            VideoPlayerController.file(globalpath[globalindex])
                                              ..initialize().then((_) {}))),
                              ),
                   )
                      
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      'Translate the video to text',
                      style: TextStyle(
                        color: Color(0xFF6FA1A2),
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.green[300]!,
                      ),
                    ),
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                          ''
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
