import 'package:devsstream/presentation/search_screen/widgets/product_card.dart';
import 'package:devsstream/presentation/search_screen/widgets/total_spending_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '/chart_service.dart';
import '../../model/product_model.dart';
import '../../repository/product_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ChartService _chartService = ChartService();
  final ProductRepository _productRepository = ProductRepository();
  late String _selectedPeriod;
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedPeriod = _chartService.getInitialPeriod();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final products = await _productRepository.getProducts();

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildProductsList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $_error'),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return ProductCard(product: _products[index]);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final periodData = _chartService.getPeriodData(_selectedPeriod);
    final xAxisData = List<String>.from(periodData['xAxisData']);
    final yAxisData = List<num>.from(periodData['yAxisData']);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Search'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildPeriodSelector(),
              const SizedBox(height: 40),
              _buildChart(xAxisData, yAxisData),
              const SizedBox(height: 20),
              const TotalSpendingCard(),
              const SizedBox(height: 30),
              _buildProductsList(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: _chartService.getTimePeriods().map((period) {
          final isSelected = period == _selectedPeriod;
          return Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: isSelected ? Colors.white : Colors.black,
                backgroundColor: isSelected ? Colors.black : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: () => setState(() => _selectedPeriod = period),
              child: Text(
                period,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart(List<String> xAxisData, List<num> yAxisData) {
    final maxY = yAxisData.reduce((a, b) => a > b ? a : b).toDouble();
    final interval = _chartService.getYAxisInterval(_selectedPeriod);

    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.white,
          gridData: FlGridData(
            show: true,
            horizontalInterval: interval,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey[300]!,
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.grey[300]!,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < xAxisData.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        xAxisData[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 30,
                interval: 1,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    _chartService.formatYAxisLabel(value),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  );
                },
                reservedSize: 60,
                interval: interval,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!, width: 1),
              left: BorderSide.none,
              right: BorderSide.none,
              top: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
          ),
          minX: 0,
          maxX: (xAxisData.length - 1).toDouble(),
          minY: 0,
          maxY: maxY * 1.1,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                xAxisData.length,
                (index) => FlSpot(
                  index.toDouble(),
                  yAxisData[index].toDouble(),
                ),
              ),
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
