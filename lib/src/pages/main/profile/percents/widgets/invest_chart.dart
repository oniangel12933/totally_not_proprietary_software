import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:involio/src/pages/main/profile/percents/bloc/invest_bloc.dart';
import 'package:involio/src/theme/colors.dart';
import 'package:pie_chart/pie_chart.dart';

class InvestChartWidget extends StatelessWidget {
  final double radius;
  final int duration;
  const InvestChartWidget(
      {Key? key, required this.radius, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InvestBloc investBloc = BlocProvider.of<InvestBloc>(context);

    return BlocBuilder<InvestBloc, InvestState>(
      builder: (context, investState) {
        return PieChart(
          dataMap: investBloc.getChartData()['data'],
          animationDuration: Duration(milliseconds: duration),
          chartLegendSpacing: 32,
          chartRadius: radius,
          colorList: investBloc.getChartData()['colors'],
          initialAngleInDegree: 180,
          chartType: ChartType.ring,
          ringStrokeWidth: 40,
          centerText: "",
          centerTextStyle:
              const TextStyle(backgroundColor: AppColors.involioBackground),
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: false,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValueBackground: true,
            showChartValues: false,
            showChartValuesInPercentage: false,
            showChartValuesOutside: true,
            decimalPlaces: 1,
          ),
        );
      },
    );
  }
}
