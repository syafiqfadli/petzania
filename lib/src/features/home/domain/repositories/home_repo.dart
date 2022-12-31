import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<PetEntity>>> getPetList();
  Future<Either<Failure, void>> deletePet(int index);
  Future<Either<Failure, void>> removeAllPets();
}
