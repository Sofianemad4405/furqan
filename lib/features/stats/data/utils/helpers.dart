String formatTime(int minutes) {
  final hours = minutes ~/ 60;
  final mins = minutes % 60;
  return hours > 0 ? '${hours}h ${mins}m' : '${mins}m';
}
