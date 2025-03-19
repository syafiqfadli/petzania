import 'package:dartz/dartz.dart';
import 'package:petzania/src/core/errors/failures.dart';
import 'package:petzania/src/core/usecases/usecase.dart';
import 'package:petzania/src/features/home/domain/repositories/home_repo.dart';

class RemoveAllPetsUseCase implements UseCase<void, NoParams> {
  final HomeRepo homeRepo;

  RemoveAllPetsUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await homeRepo.removeAllPets();
  }
}
