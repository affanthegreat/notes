/*
 * Copyright 2018, 2019, 2020 Dooboolab.
 *
 * This file is part of Flutter-Sound.
 *
 * Flutter-Sound is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 (LGPL-V3), as published by
 * the Free Software Foundation.
 *
 * Flutter-Sound is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Flutter-Sound.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:async';
import 'dart:io';

import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

typedef _Fn = void Function();
const theSource = AudioSource.microphone;

class Audio extends StatefulWidget {
  var filename;
  var self;
  Audio({this.filename,this.self, Key? key}) : super(key: key);
  String widgetType() {
    return "Audio";
  }

  String text() {
    return "";
  }

  String getFileName() {
    return filename;
  }

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> with SingleTickerProviderStateMixin {
  Codec codec = Codec.aacMP4;
  String audiopath = '';
  FlutterSoundPlayer? player = FlutterSoundPlayer();
  FlutterSoundRecorder? recorder = FlutterSoundRecorder();
  bool playerIsInited = false;
  bool recorderIsInited = false;
  bool playbackReady = false;

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      var storage = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }

    await recorder!.openAudioSession();
    recorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------
  bool isRecording = false;
  void record() {
    isRecording = true;
    recorder!
        .startRecorder(
      toFile: audiopath,
      codec: codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await recorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        playbackReady = true;
      });

    });
  }

  void play() {
    assert(playerIsInited && playbackReady && recorder!.isStopped && player!.isStopped);
    player!
        .startPlayer(
            fromURI: audiopath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    player!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  _Fn? getRecorderFn() {
    if (!recorderIsInited || !player!.isStopped) {
      return null;
    }
    return recorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!playerIsInited || !playbackReady || !recorder!.isStopped) {
      return null;
    }
    return player!.isStopped ? play : stopPlayer;
  }

  admin() async {
    Directory path = await getApplicationDocumentsDirectory();
    var file = path.path + "/audio/${widget.filename}.mp3";
    if (await Directory(file).exists() || await File(file).exists()) {
      setState(() {
        playbackReady = true;
        audiopath = file;
      });
      openTheRecorder().then((value) {
        setState(() {
          recorderIsInited = true;
        });
      });
    } else {
      widget.filename = DateTime.now().millisecondsSinceEpoch;
      audiopath = path.path.toString() + "/audio/${widget.filename}.mp3";
      openTheRecorder().then((value) {
        setState(() {
          recorderIsInited = true;
        });
      });
      player!.openAudioSession().then((value) {
        setState(() {
          playerIsInited = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    recorder!.closeAudioSession();
    player!.closeAudioSession();
    player = null;
    recorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: dark1.withOpacity(0.4),
      ),
      margin: EdgeInsets.only(left: 10, right: 10),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        child: playbackReady == true
            ? Row(
                key: UniqueKey(),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: getPlaybackFn(),
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: dark1,
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: 20,
                              color: foreground.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ))
                ],
              )
            : Row(
                key: UniqueKey(),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: getRecorderFn(),
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: dark1,
                          child: Center(
                            child: Icon(
                              Icons.pause,
                              size: 40,
                              color: foreground.withOpacity(0.5),
                            ),
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: getRecorderFn(),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 900),
                        child: isRecording
                            ? Container(
                                height: 55,
                                decoration: BoxDecoration(color: dark1, borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: BlinkText(
                                      "Stop Recording",
                                      style: poppins(
                                        Colors.red.shade300,
                                        h6,
                                      ),
                                      beginColor: Colors.red.shade300,
                                      endColor: Colors.red.shade50,
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: dark1,
                                child: Center(
                                  child: Icon(
                                    Icons.fiber_manual_record,
                                    size: 50,
                                    color: Colors.red.shade300,
                                  ),
                                ),
                              ),
                      )),
                  InkWell(
                      onTap: getRecorderFn(),
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: dark1,
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              size: 20,
                              color: foreground.withOpacity(0.5),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
      ),
    );
  }
}

