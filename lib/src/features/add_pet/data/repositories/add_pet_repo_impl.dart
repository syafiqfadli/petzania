import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/domain/repositories/core_repo.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/repositories/home_repo.dart';
import '../../domain/repositories/add_pet_repo.dart';

class AddPetRepoImpl implements AddPetRepo {
  final CoreRepo coreRepo;
  final HomeRepo homeRepo;

  AddPetRepoImpl({
    required this.coreRepo,
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, void>> addPet({required PetEntity pet}) async {
    try {
      final petListEither = await homeRepo.getPetList();

      final petList = petListEither.getOrElse(() => []);

      petList.insert(0, pet);

      await coreRepo.savePetList(petList: petList);

      return const Right(null);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
