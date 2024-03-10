import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:customer_management/common/mixin/state_mixin.dart';
import 'package:provider/provider.dart';
import 'package:customer_management/presentation/customer_list/controller.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = CustomerListController(
          service: GetIt.I.get(),
        );

        Future.microtask(controller.init);

        return controller;
      },
      builder: (context, _) {
        final controller = context.read<CustomerListController>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Customer List'),
          ),
          body: Selector<CustomerListController, ViewStatus>(
            selector: (_, controller) {
              return controller.viewStatus;
            },
            shouldRebuild: (previous, next) => true,
            builder: (context, viewStatus, _) {
              if (viewStatus == ViewStatus.loaded) {
                final state = controller.state;

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state?.length,
                  itemBuilder: (context, index) {
                    final customer = state![index];

                    return ListTile(
                      title: Text(
                        '${customer.firstName} ${customer.lastName}',
                      ),
                      subtitle: Text(customer.bankAccountNumber),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => controller.onTapEdit(context, customer),
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }

              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        );
      },
    );
  }
}
