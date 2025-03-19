import 'package:dartz/dartz.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/errors/failures.dart';

abstract class AddPetRepo {
  Future<Either<Failure, void>> addPet({required PetEntity pet});
}
