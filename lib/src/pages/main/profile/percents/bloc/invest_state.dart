part of 'invest_bloc.dart';

abstract class InvestState {
  final List<Invest> invests;

  const InvestState({this.invests = const <Invest>[]});

  @override
  List<Object> get props => [invests];
}

class InvestLoading extends InvestState {}

class InvestAdded extends InvestState {
  final List<Invest> invests;

  const InvestAdded({required this.invests}) : super(invests: invests);

  @override
  List<Object> get props => [invests];

  @override
  String toString() => 'InvestAdded { todos: $invests }';
}

class InvestUpdated extends InvestState {
  final List<Invest> invests;

  const InvestUpdated({required this.invests}) : super(invests: invests);

  @override
  List<Object> get props => [invests];

  @override
  String toString() => 'InvestUpdated { todos: $invests }';
}

class InvestRemoved extends InvestState {
  final List<Invest> invests;

  const InvestRemoved({required this.invests}) : super(invests: invests);

  @override
  List<Object> get props => [invests];

  @override
  String toString() => 'InvestRemoved { todos: $invests }';
}

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
    'color': Colors.red
  },
  {
    'title': 'Stocks',
    'icon': Assets.images.investStock,
    'color': Colors.blue
  },
  {
    'title': 'Real Estate',
    'icon': Assets.images.investRealEsate,
    'color': Colors.white
  },
  {
    'title': 'NFTs',
    'icon': Assets.images.investNft,
    'color': Colors.green
  },
  {
    'title': 'Startups',
    'icon': Assets.images.investStartup,
    'color': Colors.orange
  },
  {
    'title': 'Shoes',
    'icon': Assets.images.investShoes,
    'color': Colors.pink
  },
  {
    'title': 'Sports Cards',
    'icon': Assets.images.investSportsCards,
    'color': Colors.yellow
  },
  {
    'title': 'Pokemon Cards',
    'icon': Assets.images.investPokemon,
    'color': Colors.black
  },
  {
    'title': 'Commodities',
    'icon': Assets.images.investCommodities,
    'color': Colors.blueGrey
  },
  {
    'title': 'Private Companies',
    'icon': Assets.images.investPrivateCompany,
    'color': Colors.brown
  },
  {
    'title': 'Watches',
    'icon': Assets.images.investWatch,
    'color': Colors.lightBlue
  },
  {
    'title': 'Cars',
    'icon': Assets.images.investCar,
    'color': Colors.greenAccent
  },
  {
    'title': 'Clothing',
    'icon': Assets.images.investClothing,
    'color': Colors.cyan
  },
  {
    'title': 'Fine Art',
    'icon': Assets.images.investFineArt,
    'color': Colors.lightBlue
  },
  {
    'title': 'Jewelry',
    'icon': Assets.images.investJewelry,
    'color': Colors.amber
  },
  {
    'title': 'Coins',
    'icon': Assets.images.investCoin,
    'color': Colors.pinkAccent
  },
  {
    'title': 'Cash',
    'icon': Assets.images.investCash,
    'color': Colors.yellowAccent
  },
  {
    'title': 'Other',
    'icon': Assets.images.investOther,
    'color': Colors.cyanAccent
  },
];
