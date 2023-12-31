library qplayer;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qplayertesting/model/playercontroller.dart';
import 'package:qplayertesting/provider/playerProvider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import 'myPlayer.dart';

class QPlayer extends StatefulWidget {
  final PlayerControls playerControls;
  final ValueChanged<VideoPlayerController>? getVideoPlayerController;
  final ValueChanged<bool>? getFunctionVisibility;

  const QPlayer({
    Key? key,
    required this.playerControls,
    this.getVideoPlayerController,
    this.getFunctionVisibility,
  }) : super(key: key);

  @override
  _QPlayerState createState() => _QPlayerState();
}

class _QPlayerState extends State<QPlayer> {
  PlayerProvider _playerProvider = PlayerProvider();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _playerProvider),
      ],
      child: _playerProvider.playerControls != null
          ? MyPlayer()
          : Container(color: Colors.black),
    );
  }

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _playerProvider.setPlayerControls(widget.playerControls);
      setState(() {});

      ///send back video player controller
      if (widget.getVideoPlayerController != null) {
        Timer.periodic(Duration(seconds: 1), (timer) {
          if (_playerProvider.videoPlayerController != null) {
            if (!mounted) return;
            setState(() {
              widget.getVideoPlayerController!(
                  _playerProvider.videoPlayerController!);

              if (widget.getFunctionVisibility != null) {
                widget
                    .getFunctionVisibility!(_playerProvider.functionVisibility);
              }
            });
            timer.cancel();
          }
        });
      }

      if (widget.getFunctionVisibility != null) {
        _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
          if (_playerProvider.videoPlayerController != null) {
            if (!mounted) return;
            setState(() {
              widget.getFunctionVisibility!(_playerProvider.functionVisibility);
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    Wakelock.disable();
    _playerProvider.disposeControllers();
    _timer?.cancel();
    super.dispose();
  }
}
