import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/core/usecases/usecase.dart';
import 'package:petzania/src/features/home/domain/usecases/remove_all_pets_usecase.dart';
import 'package:petzania/src/features/home/presentation/bloc/home_bloc.dart';

class RemoveAllPetsCubit extends Cubit<void> {
  final RemoveAllPetsUseCase removeAllPetsUseCase;
  final HomeBloc homeBloc;

  RemoveAllPetsCubit({
    required this.removeAllPetsUseCase,
    required this.homeBloc,
  }) : super(null);

  Future<void> removeAllPets() async {
    await removeAllPetsUseCase(NoParams());
    homeBloc.add(GetPetListEvent());
  }
}
