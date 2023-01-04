import 'package:flutter_bloc/flutter_bloc.dart';

class IsLoadingCubit extends Cubit<bool> {
  IsLoadingCubit() : super(false);

  void setLoading() {
    emit(!state);
  }
}
