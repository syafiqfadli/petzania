import 'dart:convert';
import 'package:dartz/dartz.dart';
import '../data_sources/local_datasource.dart';
import '../../domain/entities/pet_entity.dart';
import '../../domain/repositories/core_repo.dart';
import '../../errors/failures.dart';
import '../../util/keys.dart';

class CoreRepoImpl implements CoreRepo {
  final LocalDataSource localDataSource;

  CoreRepoImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, void>> savePetList({
    required List<PetEntity> petList,
  }) async {
    try {
      final List pets = petList.map((pet) => pet.toJson()).toList();

      await localDataSource.store(LocalKeys.petList, jsonEncode(pets));

      return const Right(null);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getPetList() async {
    try {
      final petList = await localDataSource.get(LocalKeys.petList);

      if (petList == null) {
        return const Right("[]");
      }

      return Right(petList);
    } catch (error) {
      return Left(CacheFailure(message: error.toString()));
    }
  }
}
