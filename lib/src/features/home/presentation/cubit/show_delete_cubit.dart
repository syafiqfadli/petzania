import 'package:flutter_bloc/flutter_bloc.dart';

class ShowDeleteCubit extends Cubit<bool> {
  ShowDeleteCubit() : super(false);

  void showDelete() {
    emit(!state);
  }
}
