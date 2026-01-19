import 'package:flutter/material.dart';
import 'models/water_config.dart';
import 'widgets/water_wave_painter.dart';
import 'widgets/control_panel.dart';
import 'widgets/color_picker.dart';

class WaterAnimationScreen extends StatefulWidget {
  const WaterAnimationScreen({super.key});

  @override
  State<WaterAnimationScreen> createState() => _WaterAnimationScreenState();
}

class _WaterAnimationScreenState extends State<WaterAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlaying = true;
  double _speed = 1.0;
  WaterColorPreset _selectedColor = WaterColorPreset.blue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (5000 / _speed).round()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.stop();
      } else {
        _controller.repeat();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _reset() {
    setState(() {
      _controller.reset();
      _controller.repeat();
      _isPlaying = true;
    });
  }

  void _updateSpeed(double newSpeed) {
    setState(() {
      _speed = newSpeed;
      _controller.duration = Duration(milliseconds: (5000 / _speed).round());
      if (_isPlaying) {
        _controller.repeat();
      }
    });
  }

  void _changeColor(WaterColorPreset newColor) {
    setState(() {
      _selectedColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    final double maxWidth = isMobile ? double.infinity : 800;

    return Scaffold(
      backgroundColor: _selectedColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Water Fill Animation'),
        backgroundColor: _selectedColor.backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              Expanded(
                flex: isMobile ? 70 : 75,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: WaterWavePainter(
                        animationValue: _controller.value,
                        waterColor: _selectedColor.waterColor,
                      ),
                      child: Container(),
                    );
                  },
                ),
              ),
              Expanded(
                flex: isMobile ? 30 : 25,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ControlPanel(
                        isPlaying: _isPlaying,
                        speed: _speed,
                        onPlayPause: _togglePlayPause,
                        onReset: _reset,
                        onSpeedChanged: _updateSpeed,
                      ),
                      const SizedBox(height: 16),
                      ColorPicker(
                        selectedColor: _selectedColor,
                        onColorChanged: _changeColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
