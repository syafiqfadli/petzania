import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/features/pet_details/domain/usecases/update_pet_usecase.dart';

part 'update_pet_state.dart';

class UpdatePetCubit extends Cubit<UpdatePetState> {
  final UpdatePetUseCase updatePetUseCase;

  UpdatePetCubit({required this.updatePetUseCase}) : super(UpdatePetInitial());

  Future<void> updateDetails({
    required int index,
    required String name,
    required String breed,
    required String? image,
    required int age,
    required int colorValue,
  }) async {
    emit(UpdatePetInitial());

    final updatePetEither = await updatePetUseCase(UpdatePetParams(
      index: index,
      name: name,
      breed: breed,
      image: image,
      age: age,
      colorValue: colorValue,
    ));

    if (updatePetEither.isLeft()) {
      emit(UpdatePetFailed());
      return;
    }

    emit(UpdatePetSuccessful());
  }
}
