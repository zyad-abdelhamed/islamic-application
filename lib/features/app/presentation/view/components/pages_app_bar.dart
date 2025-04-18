import 'package:flutter/material.dart';
import 'package:test_app/core/constants/view_constants.dart';

final List<AppBar> pagesAppBar = List.generate(
    3,
    (index) => AppBar(
        title: Text(ViewConstants.appBarTitles(withTwoLines: false)[index]),
        ));
