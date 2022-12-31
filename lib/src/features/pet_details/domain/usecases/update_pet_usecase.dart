import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/pet_details_repo.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class UpdatePetUseCase implements UseCase<void, UpdatePetParams> {
  final PetDetailsRepo petDetailsRepo;

  UpdatePetUseCase({
    required this.petDetailsRepo,
  });

  @override
  Future<Either<Failure, void>> call(UpdatePetParams params) async {
    return await petDetailsRepo.updatePet(
      params.index,
      params.name,
      params.breed,
      params.image,
      params.age,
      params.colorValue,
    );
  }
}

class UpdatePetParams extends Equatable {
  final int index;
  final String name;
  final String breed;
  final String image;
  final int age;
  final int colorValue;

  const UpdatePetParams({
    required this.index,
    required this.name,
    required this.breed,
    required this.image,
    required this.age,
    required this.colorValue,
  });

  @override
  List<Object?> get props => [index, name, breed, image, age, colorValue];
}
