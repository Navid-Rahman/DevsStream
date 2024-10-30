import 'data/wallet_data.dart';

class WalletService {
  final Map<String, dynamic> _data = spendData;

  Map<String, dynamic> getSpendData() {
    return _data;
  }

  double getMaxSpend() {
    final spendData = _data['spend']['data'][0] as Map<String, dynamic>;
    return spendData.values
        .map((value) => (value as num).toDouble())
        .reduce((max, value) => max > value ? max : value);
  }

  List<String> getScheduleLabels() {
    final spendData = _data['spend']['data'][0] as Map<String, dynamic>;
    return spendData.values.map((value) => '\$${value.toString()}').toList();
  }

  List<double> getSpendValues() {
    final spendData = _data['spend']['data'][0] as Map<String, dynamic>;
    return [
      spendData['1st_schedule'],
      spendData['2nd_schedule'],
      spendData['3rd_schedule'],
      spendData['4th_schedule'],
      spendData['5th_schedule'],
    ].map((value) => (value as num).toDouble()).toList();
  }

  String getCurrency() {
    return _data['currency'];
  }
}
