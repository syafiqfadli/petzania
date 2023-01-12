import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_pet_list_usecase.dart';

class GetPetListCubit extends Cubit<List<PetEntity>> {
  final GetPetListUseCase getPetListUseCase;

  GetPetListCubit({
    required this.getPetListUseCase,
  }) : super([]);

  Future<void> getPetList() async {
    final petEither = await getPetListUseCase(NoParams());

    final petList = petEither.getOrElse(() => []);

    emit(petList);
  }
}
