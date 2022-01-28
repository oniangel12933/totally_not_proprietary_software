part of 'invest_bloc.dart';

abstract class InvestEvent extends Equatable {
  const InvestEvent();

  @override
  List<Object> get props => [];
}

class AddInvest extends InvestEvent {
  final Invest invest;

  const AddInvest(this.invest);

  @override
  List<Object> get props => [invest];

  @override
  String toString() => 'AddInvest { index: $invest }';
}

class UpdateInvest extends InvestEvent {
  final int index;
  final Invest invest;

  const UpdateInvest(this.index, this.invest);

  @override
  List<Object> get props => [index, invest];

  @override
  String toString() => 'UpdateInvest { index: $invest }';
}

class RemoveInvest extends InvestEvent {
  final Invest invest;

  const RemoveInvest(this.invest);

  @override
  List<Object> get props => [invest];

  @override
  String toString() => 'RemoveInvest { index: $invest }';
}

class ChangeType extends InvestEvent {}
