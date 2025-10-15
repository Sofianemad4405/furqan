import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'prayer_times_state.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit() : super(PrayerTimesInitial());
}
