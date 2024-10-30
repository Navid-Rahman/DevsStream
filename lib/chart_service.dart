import 'data/chart_data.dart';

class ChartService {
  final Map<String, dynamic> _data = chartData['data'];
  final List<String> _timePeriods = List<String>.from(chartData['timePeriods']);

  List<String> getTimePeriods() => _timePeriods;

  Map<String, dynamic> getPeriodData(String period) => _data[period];

  String getInitialPeriod() => chartData['selectedTimePeriod'];

  // Helper method to get formatted Y-axis intervals
  double getYAxisInterval(String period) {
    final yAxisData = List<num>.from(_data[period]['yAxisData']);
    final maxValue = yAxisData.reduce((a, b) => a > b ? a : b).toDouble();
    return maxValue / 5;
  }

  // Helper method to format large numbers
  String formatYAxisLabel(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(0);
  }
}
