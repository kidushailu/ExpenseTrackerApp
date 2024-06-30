// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class BarChartWidget extends StatelessWidget {
//   final List<double> expenses = [50, 70, 30, 90, 60, 40, 20]; // Example data

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Daily Expenses'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: BarChart(
//           BarChartData(
//             alignment: BarChartAlignment.spaceAround,
//             maxY: 100, // Adjust this value based on your data
//             barTouchData: BarTouchData(
//               touchTooltipData: BarTouchTooltipData(
//                 getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                   return BarTooltipItem(
//                     '${rod.toY}',
//                     TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 },
//               ),
//               touchCallback: (FlTouchEvent event, BarTouchResponse? response) {
//                 if (event is FlTapDownEvent || event is FlTapUpEvent) {
//                   print('Touched: $response');
//                 }
//               },
//               handleBuiltInTouches: true,
//             ),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   // You need to provide titles using the `showTitles` property.
                  
//                   sideTitleWidgets: List.generate(expenses.length, (index) {
//                     return SideTitleWidget(
//                       axisSide: AxisSide.bottom,
//                       child: Text([
//                         'Mon',
//                         'Tue',
//                         'Wed',
//                         'Thu',
//                         'Fri',
//                         'Sat',
//                         'Sun'
//                       ][index]),
//                     );
//                   }),
//                   // Adjust the space between the titles
//                   space: 10,
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   // You need to provide titles using the `showTitles` property.
//                   showTitles: true,
//                   axisTitleWidget: Text(
//                     'Expenses',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   sideTitleWidgets: List.generate(6, (index) {
//                     double value = index * 20.0;
//                     return SideTitleWidget(
//                       axisSide: AxisSide.left,
//                       child: Text('$value'),
//                     );
//                   }),
//                   // Adjust the space between the titles
//                   space: 10,
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(
//               show: true,
//               border: Border.all(
//                 color: const Color(0xff37434d),
//                 width: 1,
//               ),
//             ),
//             gridData: FlGridData(show: false),
//             barGroups: _generateBarGroups(expenses),
//           ),
//         ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _generateBarGroups(List<double> expenses) {
//     return List.generate(expenses.length, (index) {
//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: expenses[index],
//             color: Colors.blue,
//           ),
//         ],
//       );
//     });
//   }
// }
