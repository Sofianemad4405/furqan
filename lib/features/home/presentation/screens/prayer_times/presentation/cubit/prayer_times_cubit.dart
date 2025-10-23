import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:furqan/core/di/get_it_service.dart';
import 'package:furqan/core/entities/prayer_response_entity.dart';
import 'package:furqan/features/home/presentation/screens/prayer_times/domain/prayer_times_repo_abstract.dart';
import 'package:furqan/features/stats/data/utils/helpers.dart';
import 'package:geolocator/geolocator.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit() : super(PrayerTimesInitial());

  Future<void> getPrayerTimings(
    String date,
    double latitude,
    double longitude,
    int method,
  ) async {
    emit(PrayerTimesLoading());
    try {
      final prayerTimesRepoAbstract = sl.get<PrayerTimesRepoAbstract>();
      final response = await prayerTimesRepoAbstract.getPrayerTimings(
        date,
        latitude,
        longitude,
        method,
      );
      emit(PrayerTimesLoaded(prayerResponseEntity: response));
    } catch (e) {
      emit(PrayerTimesError(error: e.toString()));
    }
  }

  Future<PrayerResponseEntity> getPrayerResponseEntity(
    Position? userPosition,
  ) async {
    emit(PrayerTimesLoading());
    try {
      final prayerTimesRepoAbstract = sl.get<PrayerTimesRepoAbstract>();
      final response = await prayerTimesRepoAbstract.getPrayerTimings(
        formattedDate(),
        userPosition?.latitude ?? 30.5727787,
        userPosition?.longitude ?? 31.582086,
        2,
      );
      emit(PrayerTimesLoaded(prayerResponseEntity: response));
      return response;
    } catch (e) {
      emit(PrayerTimesError(error: e.toString()));
      throw Exception(e.toString());
    }
  }
}
