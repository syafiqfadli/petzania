import 'package:dartz/dartz.dart';
import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/domain/repositories/core_repo.dart';
import '../../../home/domain/repositories/home_repo.dart';
import '../../domain/repositories/pet_details_repo.dart';
import '../../../../core/errors/failures.dart';

class PetDetailsRepoImpl implements PetDetailsRepo {
  final CoreRepo coreRepo;
  final HomeRepo homeRepo;

  PetDetailsRepoImpl({
    required this.coreRepo,
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, void>> updatePet(
    int index,
    String name,
    String breed,
    String image,
    int age,
    int colorValue,
  ) async {
    try {
      final getPetListEither = await homeRepo.getPetList();

      final petList = getPetListEither.getOrElse(() => []);

      petList[index] = PetEntity(
        image: image,
        name: name,
        breed: breed,
        age: age,
        colorValue: colorValue,
      );

      await coreRepo.savePetList(petList: petList);

      return const Right(null);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
