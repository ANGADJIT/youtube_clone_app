part of 'page_cubit.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class PageIndex extends PageState {
  final int pageIndex;

  const PageIndex({
    required this.pageIndex,
  });

  @override
  List<Object> get props => [pageIndex];
}

class PageIntermediate extends PageState {}
