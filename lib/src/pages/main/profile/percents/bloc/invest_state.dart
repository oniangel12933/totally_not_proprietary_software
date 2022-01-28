part of 'invest_bloc.dart';

abstract class InvestState {
  final List<Invest> invests;

  const InvestState({this.invests = const <Invest>[]});

  List<Object> get props => [invests];
}

class InvestLoading extends InvestState {}

class InvestAdded extends InvestState {
  final List<Invest> newInvests;

  const InvestAdded({required this.newInvests}) : super(invests: newInvests);

  @override
  List<Object> get props => [newInvests];

  @override
  String toString() => 'InvestAdded { todos: $newInvests }';
}

class InvestUpdated extends InvestState {
  final List<Invest> newInvests;

  const InvestUpdated({required this.newInvests}) : super(invests: newInvests);

  @override
  List<Object> get props => [newInvests];

  @override
  String toString() => 'InvestUpdated { todos: $newInvests }';
}

class InvestRemoved extends InvestState {
  final List<Invest> newInvests;

  const InvestRemoved({required this.newInvests}) : super(invests: newInvests);

  @override
  List<Object> get props => [newInvests];

  @override
  String toString() => 'InvestRemoved { todos: $newInvests }';
}

class TypeChanged extends InvestState {}

class Invest extends Equatable {
  final int? id;
  final int? percent;

  const Invest({required this.id, required this.percent});

  @override
  List<Object> get props => [id!, percent!];
}

List<dynamic> listOfInvest = [
  {
    'title': 'Cryptocurrency',
    'icon': Assets.images.investCrypto,
    'color': const Color(0xFF004D40)
  },
  {
    'title': 'Stocks',
    'icon': Assets.images.investStock,
    'color': const Color(0xFF00695C)
  },
  {
    'title': 'Real Estate',
    'icon': Assets.images.investRealEsate,
    'color': const Color(0xFF00796B)
  },
  {
    'title': 'NFTs',
    'icon': Assets.images.investNft,
    'color': const Color(0xFF006064)
  },
  {
    'title': 'Startups',
    'icon': Assets.images.investStartup,
    'color': const Color(0xFF00838F)
  },
  {
    'title': 'Shoes',
    'icon': Assets.images.investShoes,
    'color': const Color(0xFF0097A7)
  },
  {
    'title': 'Sports Cards',
    'icon': Assets.images.investSportsCards,
    'color': const Color(0xFF01579B)
  },
  {
    'title': 'Pokemon Cards',
    'icon': Assets.images.investPokemon,
    'color': const Color(0xFF0277BD)
  },
  {
    'title': 'Commodities',
    'icon': Assets.images.investCommodities,
    'color': const Color(0xFF0288D1)
  },
  {
    'title': 'Private Companies',
    'icon': Assets.images.investPrivateCompany,
    'color': const Color(0xFF1A237E)
  },
  {
    'title': 'Watches',
    'icon': Assets.images.investWatch,
    'color': const Color(0xFF283593)
  },
  {
    'title': 'Cars',
    'icon': Assets.images.investCar,
    'color': const Color(0xFF303F9F)
  },
  {
    'title': 'Clothing',
    'icon': Assets.images.investClothing,
    'color': const Color(0xFF64B4F6)
  },
  {
    'title': 'Fine Art',
    'icon': Assets.images.investFineArt,
    'color': const Color(0xFFBBDEFB)
  },
  {
    'title': 'Jewelry',
    'icon': Assets.images.investJewelry,
    'color': const Color(0xFF29B6F6)
  },
  {
    'title': 'Coins',
    'icon': Assets.images.investCoin,
    'color': const Color(0xFFB2EBF2)
  },
  {
    'title': 'Cash',
    'icon': Assets.images.investCash,
    'color': const Color(0xFF26A69A)
  },
  {
    'title': 'Other',
    'icon': Assets.images.investOther,
    'color': const Color(0xFFE0F2F1)
  },
];
