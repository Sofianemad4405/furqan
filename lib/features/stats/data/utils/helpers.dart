String formatTime(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  final secs = seconds % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m ${secs}s';
  } else if (minutes > 0) {
    return '${minutes}m ${secs}s';
  } else {
    return '${secs}s';
  }
}

String formattedDate() {
  final now = DateTime.now();
  return "${now.day}-${now.month}-${now.year}";
}
