import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class AddPetRepo {
  Future<Either<Failure, void>> addPet({required PetEntity pet});
}
