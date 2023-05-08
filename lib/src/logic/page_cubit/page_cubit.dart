import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(const PageIndex(pageIndex: 0));

  void changePage(int pageIndex) {
    emit(PageIntermediate());
    emit(PageIndex(pageIndex: pageIndex));
  }
}
