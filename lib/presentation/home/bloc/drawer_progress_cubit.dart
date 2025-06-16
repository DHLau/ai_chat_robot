import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerProgressCubit extends Cubit<double> {
  DrawerProgressCubit() : super(0.0);

  void drawerCurrentPercent(double percent) {
    emit(percent);
  }
}
