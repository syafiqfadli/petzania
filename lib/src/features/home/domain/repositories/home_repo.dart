import 'package:dartz/dartz.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_list_entity.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';

abstract class HomeRepo {
  Future<Either<Failure, PetListEntity>> getPetList();
}
