import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/domain/usecases/add_pet_usecase.dart';

class AddPetCubit extends Cubit<void> {
  final AddPetUseCase addPetUseCase;

  AddPetCubit({
    required this.addPetUseCase,
  }) : super(null);

  Future<void> addPet({required PetEntity pet}) async {
    await addPetUseCase(AddPetParams(pet: pet));
  }
}
