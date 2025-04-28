part of 'alert_dialog_cubit.dart';

@immutable
class AlertDialogState {
  const AlertDialogState({this.progress = 0, this.selectedIndex = 0});
  final double progress;
  final int selectedIndex;
  String get getText {
    if (progress < 33) {
      return AppStrings.ringRosaryTexts[0];
    } else if (progress < 66) {
      return AppStrings.ringRosaryTexts[1];
    } else if (progress < 99) {
      return AppStrings.ringRosaryTexts[2];
    }
    return AppStrings.ringRosaryTexts[3];
  }

  Color getContainerColor(int index) {
    if (selectedIndex > index) {
      return AppColors.secondryColor;
    }
    return Colors.transparent;
  }

  String get getRingText {
    if (selectedIndex == 0) {
      return AppStrings.ringRosaryTexts[0];
    } else if (selectedIndex == 1) {
      return AppStrings.ringRosaryTexts[1];
    } else if (selectedIndex == 2) {
      return AppStrings.ringRosaryTexts[2];
    } else if (selectedIndex == 3) {
      return AppStrings.ringRosaryTexts[3];
    }
    return AppStrings.done; //when terminate
  }
}
