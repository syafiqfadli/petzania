import 'package:dartz/dartz.dart';

import '../../errors/failures.dart';
import '../entities/pet_entity.dart';

abstract class CoreRepo {
  Future<Either<Failure, void>> savePetList({required List<PetEntity> petList});
  Future<Either<Failure, String>> getPetList();
  Future<Either<Failure, void>> removeAllPets();
}
