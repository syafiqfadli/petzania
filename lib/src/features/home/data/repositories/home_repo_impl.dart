import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';
import 'package:pet_care_flutter_app/src/core/data/models/pet_model.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/domain/repositories/core_repo.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';
import 'package:pet_care_flutter_app/src/core/util/keys.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final LocalDataSource localDataSource;
  final CoreRepo coreRepo;

  HomeRepoImpl({
    required this.localDataSource,
    required this.coreRepo,
  });

  @override
  Future<Either<Failure, List<PetEntity>>> getPetList() async {
    try {
      final localPetList = await localDataSource.get(LocalKeys.petList);

      if (localPetList == null) {
        return Right(List.empty(growable: true));
      }

      final List pets = jsonDecode(localPetList);

      List<PetEntity> petList = PetModel.addToList(pets);

      return Right(petList);
    } catch (error) {
      print(error.toString());
      return Left(CacheFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePet(int index) async {
    final petListEither = await getPetList();

    final petList = petListEither.getOrElse(() => []);

    petList.removeAt(index);

    await coreRepo.savePet(petList: petList);

    return const Right(null);
  }
}
