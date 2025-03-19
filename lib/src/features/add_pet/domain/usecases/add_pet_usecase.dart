import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/errors/failures.dart';
import 'package:petzania/src/core/usecases/usecase.dart';
import 'package:petzania/src/features/add_pet/domain/repositories/add_pet_repo.dart';

class AddPetUseCase implements UseCase<void, AddPetParams> {
  final AddPetRepo addPetRepo;

  AddPetUseCase({
    required this.addPetRepo,
  });

  @override
  Future<Either<Failure, void>> call(AddPetParams params) async {
    return await addPetRepo.addPet(pet: params.pet);
  }
}

class AddPetParams extends Equatable {
  final PetEntity pet;

  const AddPetParams({
    required this.pet,
  });

  @override
  List<Object?> get props => [pet];
}
