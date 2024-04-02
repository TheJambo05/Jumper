import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumper/data/models/order/order_model.dart';
import 'package:jumper/data/repositories/order_repository.dart';
import 'package:jumper/logic/cubits/admin_cubits/order_cubit/user_order_state.dart';

class UserOrderCubit extends Cubit<UserOrderState> {
  final OrderModel order;
  UserOrderCubit(this.order) : super(UserOrderInitialState()) {
    _initialize();
  }

  final _orderRepository = OrderRepository();

  void _initialize() async {
    emit(UserOrderLoadingState(state.orders));
    try {
      final orders = await _orderRepository.fetchAllOrders();
      emit(UserOrderLoadedState(orders));
    } catch (ex) {
      emit(UserOrderErrorState(ex.toString(), state.orders));
    }
  }
}
