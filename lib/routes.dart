import 'package:devsstream/presentation/home_screen/home_screen.dart';
import 'package:devsstream/presentation/search_screen/search_screen.dart';
import 'package:devsstream/presentation/wallet_screen/wallet_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  WalletScreen.routeName: (context) => const WalletScreen(),
};
