import 'package:devsstream/presentation/home_screen/widgets/utility_card.dart';
import 'package:devsstream/presentation/home_screen/widgets/visa_card.dart';
import 'package:devsstream/presentation/home_screen/widgets/visa_card_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  int _currentPage = 0;

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

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: const Icon(
                CupertinoIcons.person_circle_fill,
                color: Colors.black,
                size: 40,
              ),
              title: const Text(
                'Hey George!',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              actions: [
                IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.bell),
                  onPressed: () {},
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: VisaCard(
                          data: cards[index],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(cards.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentPage == index ? Colors.black : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Bill Payments',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: utilities.length,
                    itemBuilder: (context, index) {
                      return UtilityCard(
                        icon: utilities[index]['icon'],
                        label: utilities[index]['label'],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Active Loans',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text('See all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: BottomNavBar(
              currentIndexNotifier: _currentIndexNotifier,
            ),
          ),
        ),
      ),
    );
  }
}
