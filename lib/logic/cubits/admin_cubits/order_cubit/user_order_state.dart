import 'package:jumper/data/models/order/order_model.dart';

abstract class UserOrderState {
  final List<OrderModel> orders;
  UserOrderState(this.orders);
}

class UserOrderInitialState extends UserOrderState {
  UserOrderInitialState() : super([]);
}

class UserOrderLoadingState extends UserOrderState {
  UserOrderLoadingState(super.orders);
}

class UserOrderLoadedState extends UserOrderState {
  UserOrderLoadedState(super.orders);
}

class UserOrderErrorState extends UserOrderState {
  final String message;
  UserOrderErrorState(this.message, super.orders);
}
