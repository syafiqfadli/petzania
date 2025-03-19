import 'package:dartz/dartz.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/domain/repositories/core_repo.dart';
import 'package:petzania/src/core/errors/failures.dart';
import 'package:petzania/src/features/add_pet/domain/repositories/add_pet_repo.dart';
import 'package:petzania/src/features/home/domain/repositories/home_repo.dart';

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
