import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_streaming_app/config/appid.dart';
import 'package:flutter_streaming_app/screens/home_screen.dart';
import 'package:flutter_streaming_app/services/auth/auth_provider.dart';
import 'package:flutter_streaming_app/services/models/user.dart';
import 'package:flutter_streaming_app/services/resources/firestore_methods.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class BroadCastScreen extends StatefulWidget {
  final bool isBroadCaster;
  final String channelId;

  const BroadCastScreen({
    super.key,
    required this.isBroadCaster,
    required this.channelId,
  });

  @override
  State<BroadCastScreen> createState() => _BroadCastScreenState();
}

class _BroadCastScreenState extends State<BroadCastScreen> {
  late final RtcEngine _engine;

  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  void _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadCaster) {
      _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      _engine.setClientRole(ClientRole.Audience);
    }
    _joinChannel();
  }

  void _addListeners() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (channel, uid, elapsed) {
          debugPrint('joinChannelSuccess $channel $uid $elapsed');
        },
        userJoined: (uid, elapsed) {
          debugPrint('userJoined $uid $elapsed');
          setState(() {
            remoteUid.add(uid);
          });
        },
        userOffline: (uid, reason) {
          debugPrint('userOffline $uid $reason');
          setState(() {
            remoteUid.removeWhere((element) => element == uid);
          });
        },
        leaveChannel: (stats) {
          debugPrint('leaveChannel $stats');
          setState(() {
            remoteUid.clear();
          });
        },
        // tokenPrivilegeWillExpire: (token) async {
        //   await getToken();
        //   await _engine.renewToken(token);
        // },
      ),
    );
  }

  void _joinChannel() async {
    // await getToken();
    if (tempToken != null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        await [Permission.microphone, Permission.camera].request();
      }
      await _engine.joinChannelWithUserAccount(
        tempToken,
        'thirdTest',
        Provider.of<UserProvider>(context, listen: false).user.uid,
      );
    }
  }

  _leaveChannel() async {
    if ('${Provider.of<UserProvider>(context, listen: false).user.uid}${Provider.of<UserProvider>(context, listen: false).user.username}' ==
        widget.channelId) {
      await FirestoreMethods().endLiveStream(widget.channelId);
    } else {
      await FirestoreMethods().updateViewCount(widget.channelId, false);
    }
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  _renderVideo(User user) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: "${user.uid}${user.username}" == widget.channelId
          ? const RtcLocalView.SurfaceView(
              zOrderMediaOverlay: true,
              zOrderOnTop: true,
            )
          : remoteUid.isNotEmpty
              ? kIsWeb
                  ? RtcRemoteView.SurfaceView(
                      uid: remoteUid[0], channelId: widget.channelId)
                  : RtcRemoteView.TextureView(
                      uid: remoteUid[0], channelId: widget.channelId)
              : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return PopScope(
      onPopInvoked: (didPop) async {
        await _leaveChannel();
        return Future.value(true);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _renderVideo(user),
            ],
          ),
        ),
      ),
    );
  }
}
