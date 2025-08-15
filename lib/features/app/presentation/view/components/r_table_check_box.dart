import 'package:flutter/material.dart';
import 'package:test_app/core/theme/app_colors.dart';
import 'package:test_app/core/utils/enums.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_cubit.dart';
import 'package:test_app/features/app/presentation/controller/cubit/rtabel_state.dart';

class RTableCheckBox extends StatefulWidget {
  const RTableCheckBox({
    super.key, required this.state, required this.constraints,required this.index
  });
  
final RtabelState state;
final BoxConstraints constraints;
final int index;

  @override
  State<RTableCheckBox> createState() => _RTableCheckBoxState();
}

class _RTableCheckBoxState extends State<RTableCheckBox> {
  late final ValueNotifier<bool?> _valueNotifier;
  @override
  void initState() {
    _valueNotifier = ValueNotifier<bool?>(null);
    super.initState();
  }
  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.constraints.maxWidth / 16, // عرض كل مربع
      height: 50, // ارتفاع المربع
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey1),
      ),
      child: Transform.scale(
        scale: 2, // تكبير علامة الصح
        child: ListenableBuilder(
          listenable: _valueNotifier,
          builder: (_, __) => Checkbox(
            value: _valueNotifier.value ?? widget.state.checkBoxsValues[widget.index],
            activeColor: Colors.transparent,
            checkColor: AppColors.successColor,
            side: BorderSide.none,
            onChanged: widget.state.requestState == RequestStateEnum.loading
                ? null // تعطيل وقت التحميل
                : (value) {
                    RtabelCubit.controller(context).changeCheckBoxValue(
                      context,
                      index: widget.index,
                      newValue: value!,
                      notifier: _valueNotifier,
                    );
                  },
          ),
        ),
      ),
    );
  }
}
