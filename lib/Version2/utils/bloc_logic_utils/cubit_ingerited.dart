import 'package:flutter_bloc/flutter_bloc.dart';

class ExtendedCubit<T> extends Cubit<T> {
  bool _isClosed = false;

  ExtendedCubit(super.initialState);

  bool get isClosed => _isClosed;

  @override
  Future<void> close() {
    _isClosed = true;
    return super.close();
  }

  @override
  void emit(T state) {
    if(_isClosed==false) {
      super.emit(state);
    }
  }
}