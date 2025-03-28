part of 'alert_dialog_cubit.dart';

@immutable
class AlertDialogState {
   final int progress ;
    String get getText {
    if (progress < 33) {
      return 'سبحان الله';
    } else if (progress < 66) {
      return 'الحمد لله';
    } else if (progress < 99) {
      return 'الله أكبر';
    } else{
      return 'لا إله إلا الله';
    } 
  }
 const AlertDialogState({ this.progress = 0});

}

