import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:customer_management/common/mixin/state_mixin.dart';
import 'package:customer_management/application/customer_facade_service.dart';
import 'package:customer_management/domain/entity/customer.dart';
import 'package:customer_management/presentation/routes.dart';

class CustomerListController extends ChangeNotifier with StateMixin<List<CustomerEntity>> {
  final CustomerFacadeService service;

  CustomerListController({required this.service});

  Future<void> init([bool refreshing = false]) async {
    if (!refreshing) {
      changeState(null, viewStatus: ViewStatus.loading);
    }

    final newState = await service.getAll();

    changeState(newState, viewStatus: ViewStatus.loaded);
  }

  Future<void> onTapEdit(BuildContext context, CustomerEntity customer) async {
    await GoRouter.of(context).push(
      Routes.saveCustomer,
      extra: customer,
    );

    await init();
  }

  Future<void> onRefresh() async {
    await init(true);
  }
}
