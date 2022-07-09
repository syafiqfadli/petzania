import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/domain/usecases/add_pet_usecase.dart';

part 'add_pet_state.dart';

class AddPetCubit extends Cubit<AddPetState> {
  final AddPetUseCase addPetUseCase;

  AddPetCubit({
    required this.addPetUseCase,
  }) : super(AddPetInitial());

  Future<void> addPet({required PetEntity pet}) async {
    emit(AddPetInitial());
    
    final addEither = await addPetUseCase(AddPetParams(pet: pet));

    if (addEither.isLeft()) {
      emit(AddPetFailed());
      return;
    }

    emit(AddPetSuccessful());
  }
}
