import 'package:flutter_bloc/flutter_bloc.dart';

class IsNameValidCubit extends Cubit<bool> {
  IsNameValidCubit() : super(false);

  void validate(String? value) {
    if (value!.isNotEmpty) {
      emit(true);
      return;
    }

    emit(false);
  }
}
