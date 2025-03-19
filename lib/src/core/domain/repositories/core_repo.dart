import 'package:dartz/dartz.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/errors/failures.dart';

abstract class CoreRepo {
  Future<Either<Failure, void>> savePetList({required List<PetEntity> petList});
  Future<Either<Failure, String>> getPetList();
  Future<Either<Failure, void>> removeAllPets();
}
