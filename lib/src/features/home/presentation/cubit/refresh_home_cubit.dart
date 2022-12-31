import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';

class RefreshHomeCubit extends Cubit<void> {
  final HomeBloc homeBloc;

  RefreshHomeCubit({
    required this.homeBloc,
  }) : super(null);

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));

    homeBloc.add(GetPetListEvent());
  }
}
