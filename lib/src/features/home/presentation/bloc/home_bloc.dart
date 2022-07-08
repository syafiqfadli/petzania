import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/get_pet_list_cubit.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPetListCubit getPetCubit;

  HomeBloc({
    required this.getPetCubit,
  }) : super(HomeInitial()) {
    on<GetPetListEvent>(_getPetList);
  }

  Future<void> _getPetList(
    GetPetListEvent event,
    Emitter<HomeState> emit,
  ) async {
    await getPetCubit.getPetList();

    final petList = getPetCubit.state.petList;

    if (petList.isEmpty) {
      emit(HomeNoPet());
      return;
    }

    emit(HomeHasPet());
  }
}
