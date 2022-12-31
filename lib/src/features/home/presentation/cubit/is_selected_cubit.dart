import 'package:flutter_bloc/flutter_bloc.dart';

class IsSelectedCubit extends Cubit<bool> {
  IsSelectedCubit() : super(false);

  void isSelected() {
    emit(!state);
  }
}
