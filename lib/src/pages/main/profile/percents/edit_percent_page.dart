import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:involio/src/pages/main/profile/percents/bloc/invest_bloc.dart';
import 'package:involio/src/pages/main/profile/percents/widgets/invest_chart.dart';
import 'package:involio/src/pages/main/profile/percents/widgets/sheet_top_handle.dart';
import 'package:involio/src/pages/main/profile/percents/widgets/text_button.dart';
import 'package:involio/src/theme/colors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class EditPercentPage extends StatefulWidget {
  const EditPercentPage({Key? key}) : super(key: key);

  @override
  EditPercentPageState createState() => EditPercentPageState();
}

class EditPercentPageState extends State<EditPercentPage> {
  ScrollController scrollController = ScrollController();
  TabController? tabbar;
  int indexOfTab = 0, indexOfBottomNav = 0;
  InvestBloc? investBloc;

  @override
  void initState() {
    super.initState();
    investBloc = BlocProvider.of<InvestBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.involioBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.involioBackground,
        elevation: 0,
        titleSpacing: -0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MyTextButton(
              icon: Icons.arrow_back_ios,
              color: Colors.white,
              iconSize: 20,
              align: MainAxisAlignment.start,
              action: () => Navigator.pop(context),
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.editPercent,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            MyTextButton(
              iconSize: 20,
              color: Colors.grey,
              align: MainAxisAlignment.end,
              action: () {},
            )
          ],
        ),
      ),
      body: BlocBuilder<InvestBloc, InvestState>(
        builder: (context, investState) {
          double heightOfInvests = investBloc!.invests.length * 60;

          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: max(
                  MediaQuery.of(context).size.height, 800.0 + heightOfInvests),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 30, left: 20, right: 20),
                    child: InvestChartWidget(
                        radius: (MediaQuery.of(context).size.width - 40) / 1.6,
                        duration: 300),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.capitalAllocation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    AppLocalizations.of(context)!.example,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.exampleInvest,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    AppLocalizations.of(context)!.investWhere,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 58.0 * investBloc!.invests.length,
                    child: ListView.separated(
                      itemCount: investBloc!.invests.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return AddInvestWidget(
                          index: index,
                          invest: investBloc!.invests[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  ),
                  MyTextButton(
                    icon: Icons.add_circle_outline,
                    label: '  ' + AppLocalizations.of(context)!.addNewInvest,
                    iconSize: 20,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.normal,
                    align: MainAxisAlignment.start,
                    action: () {
                      investBloc!
                          .add(const AddInvest(Invest(id: 0, percent: 0)));
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 100,
                          child: MyTextButton(
                            label: AppLocalizations.of(context)!.save,
                            color: Colors.white,
                            isFilled: true,
                            align: MainAxisAlignment.center,
                            action: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.totalBe100,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: investBloc!.isEqualTo100()
                                  ? Colors.white
                                  : Colors.red),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddInvestWidget extends StatelessWidget {
  final int index;
  final Invest invest;
  AddInvestWidget({
    Key? key,
    required this.index,
    required this.invest,
  }) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    InvestBloc investBloc = BlocProvider.of<InvestBloc>(context);
    String title = '';
    int percent = invest.percent!;
    if (invest.id == 0) {
      title = 'Choose Asset';
    } else {
      title = listOfInvest[invest.id! - 1]['title'];
    }
    if (percent == 0) {
      controller.text = '';
    } else {
      controller.text = percent.toString();
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 1, color: Colors.blueAccent),
              ),
              child: MyTextButton(
                  label: title,
                  icon: Icons.keyboard_arrow_down,
                  color: Colors.white,
                  isLabelFirst: true,
                  align: MainAxisAlignment.spaceBetween,
                  fontWeight: FontWeight.normal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  action: () {
                    showMaterialModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Container(
                        height: MediaQuery.of(context).size.height - 150,
                        decoration: const BoxDecoration(
                          color: AppColors.involioFillFormBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SheetTopHandleWidget(),
                            Expanded(
                              child: ListView.separated(
                                itemCount: listOfInvest.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SvgPicture.asset(
                                        listOfInvest[index]['icon']),
                                    title: Text(
                                      listOfInvest[index]['title'],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    onTap: () => investBloc.addOrUpdate(
                                      context,
                                      invest,
                                      index + 1,
                                      () => Navigator.pop(context),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 45,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    width: 1,
                    color: controller.text.isNotEmpty
                        ? index == investBloc.selectedIndex &&
                                investBloc.isGreaterTo100()
                            ? Colors.red
                            : Colors.blueAccent
                        : Colors.grey),
              ),
              child: TextFormField(
                controller: controller,
                focusNode: focus,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                keyboardType: Platform.isIOS
                    ? const TextInputType.numberWithOptions(
                        signed: true, decimal: true)
                    : TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                maxLength: 3,
                onTap: () {
                  investBloc.selectedIndex = index;
                },
                onChanged: (value) {
                  if (value.length == 3 && int.parse(value) > 100) {
                    controller.text = value.substring(0, 2);
                    controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length));
                  }

                  investBloc.add((UpdateInvest(
                      index,
                      Invest(
                          id: invest.id,
                          percent: int.parse(controller.text.isEmpty
                              ? '0'
                              : controller.text)))));
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: '#',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 15, left: 10),
                    child: Text(
                      '%',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: MyTextButton(
              icon: Icons.close,
              color: Colors.white,
              iconSize: 20,
              align: MainAxisAlignment.center,
              action: () {
                investBloc.add(RemoveInvest(invest));
              },
            ),
          ),
        ],
      ),
    );
  }
}
