import 'package:flutter/material.dart';

bool isLandScapeOrientation(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;
