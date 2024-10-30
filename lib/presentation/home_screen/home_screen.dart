import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/sample_data.dart';
import 'widgets/active_loan_products.dart';
import 'widgets/utility_card.dart';
import 'widgets/visa_card.dart';

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
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: activeLoans.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: MediaQuery.of(context).size.width / 1.4,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://media.istockphoto.com/id/1150425295/photo/3d-illustration-of-generic-hatchback-car-perspective-view.jpg?s=1024x1024&w=is&k=20&c=bm5iqq6Vq1hYtlety6VLiga7hITUCDpr46qhbfXRs_4=',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 24),
                              ActiveLoansProducts(
                                amount: activeLoans[index]['amount'],
                                nextDate: activeLoans[index]['nextDate'],
                                model: activeLoans[index]['model'],
                                progress: activeLoans[index]['progress'],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
