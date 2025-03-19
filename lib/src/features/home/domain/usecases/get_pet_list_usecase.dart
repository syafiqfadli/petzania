import 'package:dartz/dartz.dart';
import 'package:petzania/src/core/domain/entities/pet_entity.dart';
import 'package:petzania/src/core/errors/failures.dart';
import 'package:petzania/src/core/usecases/usecase.dart';
import 'package:petzania/src/features/home/domain/repositories/home_repo.dart';

class GetPetListUseCase implements UseCase<List<PetEntity>, NoParams> {
  final HomeRepo homeRepo;

  GetPetListUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, List<PetEntity>>> call(NoParams params) async {
    return await homeRepo.getPetList();
  }
}
