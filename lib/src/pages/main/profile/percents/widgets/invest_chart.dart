import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:involio/src/pages/main/profile/percents/bloc/invest_bloc.dart';
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
        return GestureDetector(
          onTap: () {
            investBloc.add(ChangeType());
          },
          child: PieChart(
            dataMap: investBloc.getChartData()['data'],
            animationDuration: Duration(milliseconds: duration),
            chartLegendSpacing: 32,
            chartRadius: radius,
            colorList: investBloc.getChartData()['colors'],
            initialAngleInDegree: 180,
            chartType: investBloc.isTypeRing ? ChartType.ring : ChartType.disc,
            ringStrokeWidth: 40,
            centerText: investBloc.isTypeRing
                ? AppLocalizations.of(context)!.portfoiloAndStrategy
                : "",
            centerTextStyle: const TextStyle(
                color: Colors.white,
                height: 1.5,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            legendOptions: const LegendOptions(
              showLegendsInRow: true,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: !investBloc.isTypeRing,
              chartValueStyle: const TextStyle(color: Colors.white),
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        );
      },
    );
  }
}
