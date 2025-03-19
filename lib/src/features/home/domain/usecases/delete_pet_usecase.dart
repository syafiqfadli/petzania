import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:petzania/src/core/errors/failures.dart';
import 'package:petzania/src/core/usecases/usecase.dart';
import 'package:petzania/src/features/home/domain/repositories/home_repo.dart';

class DeletePetUseCase implements UseCase<void, DeletePetParams> {
  final HomeRepo homeRepo;

  DeletePetUseCase({
    required this.homeRepo,
  });

  @override
  Future<Either<Failure, void>> call(DeletePetParams params) async {
    return await homeRepo.deletePet(params.index);
  }
}

class DeletePetParams extends Equatable {
  final int index;

  const DeletePetParams({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
