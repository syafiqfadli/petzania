import 'package:flutter_bloc/flutter_bloc.dart';

class IsColorSelectedCubit extends Cubit<bool> {
  IsColorSelectedCubit() : super(false);

  void isSelected() {
    emit(true);
  }
}
