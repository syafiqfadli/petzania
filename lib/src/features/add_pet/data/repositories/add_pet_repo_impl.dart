import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_list_entity.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';
import 'package:pet_care_flutter_app/src/core/util/keys.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/domain/repositories/add_pet_repo.dart';

class AddPetRepoImpl implements AddPetRepo {
  final LocalDataSource localDataSource;
  PetListEntity list = PetListEntity(petList: List.empty(growable: true));

  AddPetRepoImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> addPet({required PetEntity pet}) async {
    try {
      list.petList.add(pet);

      final List pets = list.petList.map((pet) => pet.toJson()).toList();

      await localDataSource.store(LocalKeys.petList, jsonEncode(pets));

      return const Right(null);
    } catch (error) {
      print(error.toString());
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
