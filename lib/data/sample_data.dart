import 'package:flutter/material.dart';

import '../presentation/home_screen/widgets/visa_card_data.dart';

final List<VisaCardData> cards = [
  VisaCardData(
    color: Colors.black,
    cardNumber: '** **** 1234',
    dueDate: 'Due Date 10th Oct',
    amount: '\$ 5,000.89',
  ),
  VisaCardData(
    color: Colors.blue,
    cardNumber: '** **** 5678',
    dueDate: 'Due Date 15th Nov',
    amount: '\$ 3,200.50',
  ),
  VisaCardData(
    color: Colors.red,
    cardNumber: '** **** 9101',
    dueDate: 'Due Date 20th Dec',
    amount: '\$ 1,500.75',
  ),
  VisaCardData(
    color: Colors.green,
    cardNumber: '** **** 1121',
    dueDate: 'Due Date 25th Jan',
    amount: '\$ 2,800.00',
  ),
];

final List<Map<String, dynamic>> utilities = [
  {
    'icon': Icons.light_mode_outlined,
    'label': 'Electricity\nBill',
  },
  {
    'icon': Icons.wifi_off_outlined,
    'label': 'Internet\nRecharge',
  },
  {
    'icon': Icons.connected_tv,
    'label': 'Cable\nBill',
  },
  {
    'icon': Icons.mobile_screen_share_outlined,
    'label': 'Mobile\nRecharge',
  },
  {
    'icon': Icons.local_gas_station,
    'label': 'Gas\nBill',
  },
  {
    'icon': Icons.water_damage,
    'label': 'Water\nBill',
  },
  {
    'icon': Icons.money,
    'label': 'Loan\nPayment',
  }
];

final List<Map<String, dynamic>> activeLoans = [
  {
    'amount': '\$399/M',
    'nextDate': '5th Oct',
    'model': 'Model X',
    'progress': 48 / 60,
  },
  {
    'amount': '\$299/M',
    'nextDate': '10th Oct',
    'model': 'Model Y',
    'progress': 30 / 60,
  },
];
