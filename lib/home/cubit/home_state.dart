part of 'home_cubit.dart';

enum HomeTab { blog, map, weather, profile }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.blog,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
