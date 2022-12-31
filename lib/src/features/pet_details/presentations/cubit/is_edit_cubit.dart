import 'package:flutter_bloc/flutter_bloc.dart';

class IsEditCubit extends Cubit<bool> {
  IsEditCubit() : super(false);

  void isEdit() {
    emit(!state);
  }

  void reset() {
    emit(false);
  }
}
