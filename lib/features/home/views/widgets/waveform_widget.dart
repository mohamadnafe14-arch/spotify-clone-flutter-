import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/core/theme/app_palette.dart';

class WaveformWidget extends StatefulWidget {
  const WaveformWidget({super.key, required this.path});
  final String path;
  @override
  State<WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget> {
  final PlayerController _controller = PlayerController();
  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() async {
    await _controller.preparePlayer(path: widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _controller.playerState.isPlaying
            ? IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  _controller.pausePlayer();
                  setState(() {});
                },
              )
            : IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  _controller.startPlayer();
                  setState(() {});
                },
              ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: _controller,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Pallete.borderColor,
              liveWaveColor: Pallete.gradient2,
              showSeekLine: false,
            ),
          ),
        ),
      ],
    );
  }
}
