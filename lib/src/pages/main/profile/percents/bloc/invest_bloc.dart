import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:involio/gen/assets.gen.dart';
import 'package:toast/toast.dart';

part 'invest_event.dart';
part 'invest_state.dart';

class InvestBloc extends Bloc<InvestEvent, InvestState> {
  final List<Invest> invests = [
    const Invest(id: 3, percent: 24),
    const Invest(id: 7, percent: 18),
    const Invest(id: 11, percent: 26),
    const Invest(id: 9, percent: 18)
  ];
  int selectedIndex = 0;

  InvestBloc()
      : super(const InvestAdded(invests: [Invest(id: 0, percent: 0)])) {
    on<AddInvest>((event, emit) async {
      addInvest(event, emit);
    });
    on<UpdateInvest>((event, emit) async {
      updateInvest(event, emit);
    });
    on<RemoveInvest>((event, emit) {
      removeInvest(event, emit);
    });
  }

  List<Invest> get items => invests;

  void addInvest(AddInvest event, Emitter<InvestState> emit) {
    invests.add(event.invest);
    emit(InvestAdded(invests: invests));
  }

  void updateInvest(UpdateInvest event, Emitter<InvestState> emit) {
    invests[event.index] = event.invest;
    emit(InvestUpdated(invests: invests));
  }

  void removeInvest(RemoveInvest event, Emitter<InvestState> emit) {
    invests.remove(event.invest);
    emit(InvestRemoved(invests: invests));
  }

  void addOrUpdate(
      BuildContext context, Invest invest, int newId, Function action) {
    if (invests.where((element) => element.id == newId).toList().isNotEmpty) {
      Toast.show(
        'Already added this item',
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: const Color(0xFF1B130F),
        textColor: Colors.white,
      );
    } else {
      add((UpdateInvest(invests.indexOf(invest),
          Invest(id: newId, percent: invest.percent))));
      action();
    }
  }

  bool isEqualTo100() {
    int total = 0;
    for (Invest item in invests) {
      total += item.percent!;
    }
    return total == 100;
  }

  bool isGreaterTo100() {
    int total = 0;
    for (Invest item in invests) {
      total += item.percent!;
    }
    return total > 100;
  }

  bool isEmptyInvest(Invest invest) {
    return invest.id == 0 || invest.percent == 0;
  }

  Map<String, dynamic> getChartData() {
    Map<String, double> chartDataMap = {};
    List<Color> chartColors = [];

    for (Invest invest in invests) {
      if (!isEmptyInvest(invest)) {
        dynamic data = listOfInvest[invest.id! - 1];
        chartDataMap[data['title']] = invest.percent!.toDouble();
        chartColors.add(data['color']);
      }
    }
    if (chartDataMap.isEmpty) {
      chartDataMap['empty'] = 100;
      chartColors = [Colors.grey];
    } else {
      double total =
          chartDataMap.values.reduce((sum, element) => sum + element);
      if (total < 100) {
        chartDataMap['empty'] = 100 - total;
        chartColors.add(Colors.grey);
      }
    }

    return {'data': chartDataMap, 'colors': chartColors};
  }

  bool isExisted(Invest invest) {
    final list = invests.where((element) => element.id == invest.id).toList();
    return list.isNotEmpty && list.isNotEmpty;
  }
}
