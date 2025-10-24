import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/adaptive/adaptive_widgets/get_adaptive_loading_widget.dart';
import 'package:test_app/core/constants/constants_values.dart';

class AppFunctionaltyButton<C extends StateStreamable<S>, S>
    extends StatelessWidget {
  const AppFunctionaltyButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.isLoading,
    this.disabled = false,
  });

  final String buttonName;
  final bool disabled;
  final void Function()? onPressed;

  /// دالة ترجع bool بناءً على ال state
  final bool Function(S state) isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      builder: (context, state) {
        final bool loading = isLoading(state);

        return MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(ConstantsValues.fullCircularRadius),
          ),
          onPressed: disabled
              ? null
              : loading
                  ? () {}
                  : onPressed,
          disabledColor: Colors.grey,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: loading
                ? Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("جارٍ المعالجة ..."),
                      const AppLoadingWidget(),
                    ],
                  )
                : Text(
                    buttonName,
                    style: const TextStyle(color: Colors.white),
                  ),
          ),
        );
      },
    );
  }
}
