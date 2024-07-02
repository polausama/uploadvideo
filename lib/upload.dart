import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/tranlate.dart';
import 'package:video_player/video_player.dart';
int globalindex = 0;
List globalpath = [];

class UploadVid extends StatefulWidget {
  const UploadVid({super.key});

  @override
  State<UploadVid> createState() => _UploadVidState();
}

class _UploadVidState extends State<UploadVid> {
File? video;
  bool uploaded = false;
  bool pressed = false;
  final picker = ImagePicker();
  pickVideo() async {
    setState(() {
      pressed = true;
    });
    final vid = await picker.pickVideo(source: ImageSource.gallery);
    video = File(vid!.path);
    setState(() {
      uploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: ImageIcon(
                    AssetImage("assets/images/Vector.png"),
                  ),
                  onPressed: () {},
                ),
                Text(
                  'Videos',
                  style: TextStyle(
                      fontFamily: "inter",
                      color: Color(0xFFA86434),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      body: 
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 13),
             child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90,),
                Center(
                  child: InkWell(
                    onTap: () {
                      getVideoFile();
                    },
                    child: 
                    Container(
                      height: 82,
                      width: 292,
                      decoration: BoxDecoration(
                          color: Color(0xFF649192),
                          borderRadius: BorderRadius.circular(9)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Choose video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight:FontWeight.w600 ,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Image(image: AssetImage("assets/images/Vector2.png"))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Text('In Queue:',
                style:TextStyle(
                  color: Color(0xFFA86434),
                  fontWeight:FontWeight.w600 ,
                  fontSize: 24,

                ) ,),
                SizedBox(height: 23,),

                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return video != null
                        ? Container(
                            child: Column(
                              children: [
                                Center(
                              child:
                               FlickVideoPlayer(
                                  flickManager: FlickManager(
                                      videoPlayerController:
                                          VideoPlayerController.file(video!)
                                            ..initialize().then((_) {}))),
                            ),
                            MaterialButton(
                              child: Text('continue'),
                              onPressed: () {
                                print('object');
                                   globalindex = index;
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Translate()));
                              },)
                              ],
                            )
                          )
                        : 
                        Container(
                        width:337 ,
                        height:226 ,
                        color: Colors.white,
                                            );
                    },),
                ),
                // Center(
                //   child: MaterialButton(
                //           color: Colors.greenAccent,
                //           onPressed: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => const Translate()));
                //             setState(() {
                //               pressed = false;
                //               uploaded = false;
                //             });
                //           },
                //            child: const Text(
                //           'Continue',
                //         ),
                //       )
                //     : const SizedBox(),
                // pressed && !uploaded
                //     ? const CircularProgressIndicator()
                //     : const SizedBox(),),
                // )
                // uploaded && pressed
                //     ? const Text('video Uploaded successfully')
                //     : const SizedBox(),
                // const SizedBox(
                //   height: 50,
                // ),
                // uploaded && pressed
                //     ? MaterialButton(
                //         color: Colors.greenAccent,
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => const Translate()));
                //           setState(() {
                //             pressed = false;
                //             uploaded = false;
                //           });
                //         },
                //         child: const Text(
                //           'Continue',
                //         ),
                //       )
                //     : const SizedBox(),
                // pressed && !uploaded
                //     ? const CircularProgressIndicator()
                //     : const SizedBox(),
              ],
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
          globalpath.add(video);
        });
        print(globalpath);
      }
    }
  }
}
