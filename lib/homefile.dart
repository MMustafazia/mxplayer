import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qplayertesting/model/playercontroller.dart';
import 'package:qplayertesting/qpalyer.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayerPage extends StatefulWidget {
  @override
  _MyVideoPlayerPageState createState() => _MyVideoPlayerPageState();
}

class _MyVideoPlayerPageState extends State<MyVideoPlayerPage> {
  late VideoPlayerController videoPlayerController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QPlayer(
        playerControls: PlayerControls(
            videoUrl:
                'https://vod-progressive.akamaized.net/exp=1702289063~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F4060%2F12%2F320304435%2F1241959326.mp4~hmac=26407e125cb9198f9309aefca9373a5552446f16770d2dddcb1a511af8017cd5/vimeo-prod-skyfire-std-us/01/4060/12/320304435/1241959326.mp4'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft]); //change device Orientation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }
}
