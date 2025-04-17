part of 'quran_cubit.dart';

class QuranState extends Equatable {
  final String? filePath;
  final double width;
  final double height;
  final String floatingActionButtonString;
  const QuranState({this.filePath,this.height = 0.0,this.width = 0.0,this.floatingActionButtonString = 'الفهرس'});

  @override
  List<Object?> get props => [filePath,height,width];
}
