import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/bloc/home_bloc.dart';

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
