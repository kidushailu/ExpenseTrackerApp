// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class BarChartWidget extends StatelessWidget {
//   final List<BarChartGroupData> barChartGroups;
//   final String title;

//   BarChartWidget(
//       {required this.barChartGroups, this.title = 'Monthly Expenses'});

//   factory BarChartWidget.withExpenseData(
//       List<Map<String, dynamic>> expenseData) {
//     final expenseMap = <String, double>{};

//     for (var expense in expenseData) {
//       String category = expense['category'];
//       double amount = expense['amount'];
//       if (expenseMap.containsKey(category)) {
//         expenseMap[category] = expenseMap[category]! + amount;
//       } else {
//         expenseMap[category] = amount;
//       }
//     }

//     final barChartGroups = expenseMap.entries.map((entry) {
//       return BarChartGroupData(
//         x: entry.key.hashCode % 10, // Convert category to an integer
//         barRods: [
//           BarChartRodData(
//             toY: entry.value,
//             color: Colors.blue, // Customize the bar color
//             width: 20, // Customize the bar width
//             backDrawRodData: BackgroundBarChartRodData(
//               toY: 0,
//               color: Colors.grey[300]!,
//               width: 20,
//             ),
//           ),
//         ],
//       );
//     }).toList();

//     return BarChartWidget(barChartGroups: barChartGroups);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: Theme.of(context).textTheme.headline6,
//           ),
//           SizedBox(height: 16),
//           BarChart(
//             BarChartData(
//               gridData: FlGridData(show: false),
//               titlesData: FlTitlesData(
//                   bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 40,
//                 textStyle: TextStyle(fontSize: 14, color: Colors.black),
//                 getTitlesWidget: (value, meta) {
//                   final category =
//                       expenseData[value.toInt() % expenseData.length]
//                           ['category'];
//                   return SideTitleWidget(
//                     axisSide: meta.axisSide,
//                     child: Text(
//                       category,
//                       style: TextStyle(fontSize: 14, color: Colors.black),
//                     ),
//                   );
//                 },
//               ))),
//               leftTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 40,
//                 textStyle: TextStyle(fontSize: 14, color: Colors.black),
//                 margin: 10,
//                 getTitlesWidget: (value, meta) {
//                   return SideTitleWidget(
//                     axisSide: meta.axisSide,
//                     child: Text(
//                       '${value.toStringAsFixed(2)}',
//                       style: TextStyle(fontSize: 14, color: Colors.black),
//                     ),
//                   );
//                 },
//               ),
//               topTitles: SideTitles(
//                 showTitles: false,
//               ),
//               rightTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             borderData: FlBorderData(
//               show: true,
//               border: Border.all(
//                 color: Colors.black.withOpacity(0.5),
//                 width: 1,
//               ),
//             ),
//             barGroups: barChartGroups,
//             alignment: BarChartAlignment.spaceAround,
//             minY: 0, // Set minimum Y value for the chart
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   getTitlesWidget: (value, meta) {
//                     final index = value.toInt();
//                     if (index >= 0 && index < expenseData.length) {
//                       final category = expenseData[index]['category'];
//                       return SideTitleWidget(
//                         axisSide: meta.axisSide,
//                         child: Text(
//                           category,
//                           style: TextStyle(fontSize: 14, color: Colors.black),
//                         ),
//                       );
//                     }
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: Text(''),
//                     );
//                   },
//                 ),
//                 leftTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40,
//                   getTitlesWidget: (value, meta) {
//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       child: Text(
//                         '${value.toStringAsFixed(2)}',
//                         style: TextStyle(fontSize: 14, color: Colors.black),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             children: [
//               Container(
//                 width: 16,
//                 height: 16,
//                 color: Colors.blue, // The color of the bar
//               ),
//               SizedBox(width: 8),
//               Text('Expenses') // Your legend text
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   DatabaseHelper dbHelper = DatabaseHelper();
//   List<Map<String, dynamic>> expenses = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchMonthlyExpenses();
//   }

//   Future<void> _fetchMonthlyExpenses() async {
//     List<Map<String, dynamic>> data = await dbHelper.getMonthlyExpenses();
//     setState(() {
//       expenses = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Monthly Expenses'),
//       ),
//       body: expenses.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : BarChartWidget.withExpenseData(expenses),
//     );
//   }
// }
