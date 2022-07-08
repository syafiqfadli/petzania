import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';
import 'package:pet_care_flutter_app/src/core/data/models/pet_list_model.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_list_entity.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';
import 'package:pet_care_flutter_app/src/core/util/keys.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final LocalDataSource localDataSource;

  HomeRepoImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, PetListEntity>> getPetList() async {
    try {
      final localPetList = await localDataSource.get(LocalKeys.petList);

      if (localPetList == null) {
        return Right(PetListEntity.empty);
      }

      final List pets = jsonDecode(localPetList);

      final petList = PetListModel.create(pets);

      return Right(petList);
    } catch (error) {
      print(error.toString());
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
