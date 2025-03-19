import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/features/home/presentation/cubit/get_pet_list_cubit.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetPetListCubit getPetListCubit;

  HomeBloc({
    required this.getPetListCubit,
  }) : super(HomeInitial()) {
    on<GetPetListEvent>(_getPetList);
  }

  Future<void> _getPetList(
    GetPetListEvent event,
    Emitter<HomeState> emit,
  ) async {
    await getPetListCubit.getPetList();

    final petList = getPetListCubit.state;

    if (petList.isEmpty) {
      emit(HomeNoPet());
      return;
    }

    emit(HomeHasPet());
  }
}
