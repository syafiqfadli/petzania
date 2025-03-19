import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/usecases/usecase.dart';
import 'package:petzania/src/features/home/domain/usecases/get_pet_list_usecase.dart';

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
