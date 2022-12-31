import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../../../../core/data/models/pet_model.dart';
import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/domain/repositories/core_repo.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final CoreRepo coreRepo;

  HomeRepoImpl({
    required this.coreRepo,
  });

  @override
  Future<Either<Failure, List<PetEntity>>> getPetList() async {
    try {
      final petListEither = await coreRepo.getPetList();

      final localPetList = petListEither.getOrElse(() => "[]");

      final List pets = jsonDecode(localPetList);

      List<PetEntity> petList = PetModel.addToList(pets);

      return Right(petList);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePet(int index) async {
    final petListEither = await getPetList();

    final petList = petListEither.getOrElse(() => []);

    petList.removeAt(index);

    await coreRepo.savePetList(petList: petList);

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeAllPets() async {
    await coreRepo.removeAllPets();

    return const Right(null);
  }
}
