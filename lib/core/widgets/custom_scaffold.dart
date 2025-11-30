import 'package:flutter/material.dart';
import 'package:test_app/core/utils/extentions/theme_extention.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  const CustomScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = context.isDarkMode
        ? const [
            Color(0xFF1F2A2C),
            Color(0xFF0F1718),
          ]
        : const [
            Color(0xFFE8F4F7),
            Color(0xFFF2FAF7),
          ];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : Container(
              decoration: BoxDecoration(
                gradient: _linearGradient(gradientColors),
              ),
              child: bottomNavigationBar,
            ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomSheet: bottomSheet,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: Column(
          children: [
            if (appBar != null) CustomTopBar(appBar: appBar),
            Expanded(
              child: body ?? const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _linearGradient(List<Color> gradientColors) {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: gradientColors,
    );
  }

  double getPreferredAppBarHeight(PreferredSizeWidget? appBar) {
    double bottomHeight = 0.0;

    // تحقق أن appBar فعليًا AppBar
    if (appBar is AppBar && appBar.bottom != null) {
      bottomHeight = appBar.bottom!.preferredSize.height;
    }

    return kToolbarHeight + bottomHeight;
  }
}
