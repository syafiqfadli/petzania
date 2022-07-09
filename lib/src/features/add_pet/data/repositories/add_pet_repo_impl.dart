import 'package:dartz/dartz.dart';

import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/domain/repositories/core_repo.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/domain/repositories/add_pet_repo.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/repositories/home_repo.dart';

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

      await coreRepo.savePet(petList: petList);

      return const Right(null);
    } catch (error) {
      print(error.toString());
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
