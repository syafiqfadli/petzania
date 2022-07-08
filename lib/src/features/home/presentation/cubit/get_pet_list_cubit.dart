import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_list_entity.dart';
import 'package:pet_care_flutter_app/src/core/usecases/usecase.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/usecases/get_pet_list_usecase.dart';

class GetPetListCubit extends Cubit<PetListEntity> {
  final GetPetListUseCase getPetListUseCase;

  GetPetListCubit({
    required this.getPetListUseCase,
  }) : super(PetListEntity.empty);

  Future<void> getPetList() async {
    final petEither = await getPetListUseCase(NoParams());

    final petList = petEither.getOrElse(() => PetListEntity.empty);

    emit(petList);
  }
}
