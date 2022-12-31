import 'package:dartz/dartz.dart';
import '../entities/pet_entity.dart';
import '../../errors/failures.dart';

abstract class CoreRepo {
  Future<Either<Failure, void>> savePetList({required List<PetEntity> petList});
  Future<Either<Failure, String>> getPetList();
}
