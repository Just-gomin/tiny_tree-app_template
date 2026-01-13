import 'package:flutter/material.dart';

enum TetrominoType { I, O, T, S, Z, J, L }

const neonColors = {
  TetrominoType.I: Color(0xFF00F0FF),
  TetrominoType.O: Color(0xFFFFFF00),
  TetrominoType.T: Color(0xFFFF00FF),
  TetrominoType.S: Color(0xFF00FF00),
  TetrominoType.Z: Color(0xFFFF0040),
  TetrominoType.J: Color(0xFF0080FF),
  TetrominoType.L: Color(0xFFFF8000),
};

const backgroundColor = Color(0xFF0A0E27);
const gridLineColor = Color(0x33007FFF);

const int gridWidth = 10;
const int gridHeight = 20;
const int initialDropSpeed = 800;
const int levelSpeedDecrease = 50;
const int pointsPerLine = 100;
const int linesPerLevel = 10;
