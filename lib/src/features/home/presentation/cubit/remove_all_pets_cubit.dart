import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/remove_all_pets_usecase.dart';

import '../bloc/home_bloc.dart';

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
