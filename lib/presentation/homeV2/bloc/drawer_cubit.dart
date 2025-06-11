import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerCubit extends Cubit<bool> {
  DrawerCubit() : super(false);

  void drawerToggle() => emit(!state);
  void drawerOpen() => emit(true);
  void drawerClose() => emit(false);
}
