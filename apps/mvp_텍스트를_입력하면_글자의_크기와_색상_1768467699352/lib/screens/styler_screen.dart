import 'package:flutter/material.dart';
import '../models/text_style_state.dart';
import '../widgets/text_input_field.dart';
import '../widgets/text_preview.dart';
import '../widgets/font_size_slider.dart';
import '../widgets/color_picker.dart';

class StylerScreen extends StatefulWidget {
  const StylerScreen({super.key});

  @override
  State<StylerScreen> createState() => _StylerScreenState();
}

class _StylerScreenState extends State<StylerScreen> {
  late TextStyleState _state;

  @override
  void initState() {
    super.initState();
    _state = TextStyleState.defaultState;
  }

  void _updateText(String text) {
    setState(() {
      _state = _state.copyWith(text: text);
    });
  }

  void _updateFontSize(double fontSize) {
    setState(() {
      _state = _state.copyWith(fontSize: fontSize);
    });
  }

  void _updateColor(Color color) {
    setState(() {
      _state = _state.copyWith(textColor: color);
    });
  }

  void _resetStyles() {
    setState(() {
      _state = TextStyleState.defaultState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Styler ✨'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextInputField(
                    value: _state.text,
                    onChanged: _updateText,
                  ),
                  const SizedBox(height: 32),
                  TextPreview(
                    text: _state.text,
                    fontSize: _state.fontSize,
                    textColor: _state.textColor,
                  ),
                  const SizedBox(height: 32),
                  FontSizeSlider(
                    value: _state.fontSize,
                    min: minFontSize,
                    max: maxFontSize,
                    onChanged: _updateFontSize,
                  ),
                  const SizedBox(height: 32),
                  ColorPicker(
                    selectedColor: _state.textColor,
                    colors: colorPalette,
                    onColorSelected: _updateColor,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: _resetStyles,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Styles'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
