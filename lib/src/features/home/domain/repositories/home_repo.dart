import 'package:dartz/dartz.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/errors/failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<PetEntity>>> getPetList();
  Future<Either<Failure, void>> deletePet(int index);
  Future<Either<Failure, void>> removeAllPets();
}
