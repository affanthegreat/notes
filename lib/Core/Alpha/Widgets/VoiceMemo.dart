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

import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';

typedef _Fn = void Function();
const theSource = AudioSource.microphone;

class Audio extends StatefulWidget {
  const Audio({Key? key}) : super(key: key);
  String widgetType() {
    return "Audio";
  }

  String text() {
    return "";
  }

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> with SingleTickerProviderStateMixin {
  Codec _codec = Codec.aacMP4;
  String _mPath = 'tau_file.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  AnimationController? animationController;
  @override
  void initState() {
    _mPlayer!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _mRecorder!.closeAudioSession();
    _mPlayer!.closeAudioSession();
    _mPlayer = null;
    _mRecorder = null;
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      var storage = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
      _mPath = 'tau_file.webm';
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------
  bool isRecording = false;
  void record() {
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    isRecording = true;
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited && _mplaybackReady && _mRecorder!.isStopped && _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              setState(() {});
            })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

// ----------------------------- UI --------------------------------------------

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }
    return _mRecorder!.isStopped ? record : stopRecorder;
  }

  _Fn? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
      return null;
    }
    return _mPlayer!.isStopped ? play : stopPlayer;
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
        child: _mplaybackReady == true
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
                              size: 20,
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

class RecordingAnimation extends StatelessWidget {
  const RecordingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double opacity, Widget? child) {
          return Opacity(opacity: opacity, child: Container(width: 20, height: 20, color: Colors.red));
        });
  }
}
