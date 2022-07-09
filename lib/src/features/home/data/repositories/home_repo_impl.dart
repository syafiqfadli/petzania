import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';
import 'package:pet_care_flutter_app/src/core/data/models/pet_model.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';
import 'package:pet_care_flutter_app/src/core/util/keys.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final LocalDataSource localDataSource;

  HomeRepoImpl({
    required this.localDataSource,
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
}
