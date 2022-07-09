import 'package:dartz/dartz.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';

abstract class CoreRepo {
  Future<Either<Failure, void>> savePet({required List<PetEntity> petList});
}
