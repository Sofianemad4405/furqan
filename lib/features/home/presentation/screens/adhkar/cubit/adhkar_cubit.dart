import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/entities/azkar_section_entity.dart';
import 'package:furqan/features/home/domain/home_repo_abstract.dart';

part 'adhkar_state.dart';

class AdhkarCubit extends Cubit<AdhkarState> {
  final HomeRepoAbstract homeRepo;
  AdhkarCubit(this.homeRepo) : super(AdhkarInitial());

  void init() {
    emit(const AdhkarCategoriesLoaded());
  }

  Future<void> getAdhkar(String category) async {
    emit(AdhkarLoading());
    try {
      final adhkar = await homeRepo.getAdhkar(category);
      emit(AdhkarLoaded(adhkar: adhkar));
    } catch (e) {
      log(e.toString());
      emit(AdhkarError(message: e.toString()));
    }
  }

  Future<AzkarSectionEntity> getSectionAdhkar(String category) async {
    try {
      final adhkar = await homeRepo.getAdhkar(category);
      log(adhkar.title);
      return adhkar;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
