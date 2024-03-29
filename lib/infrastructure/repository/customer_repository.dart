import 'package:customer_management/domain/entity/customer.dart';
import 'package:customer_management/domain/interface/customer_repository.dart';
import 'package:customer_management/infrastructure/provider/hive_data_provider.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final HiveDataProvider dataProvider;

  CustomerRepositoryImpl({
    required this.dataProvider,
  });

  @override
  Future<void> add(CustomerEntity customer) {
    return dataProvider.add(customer);
  }

  @override
  Future<CustomerEntity?> get(String id) async {
    return dataProvider.get(id);
  }

  @override
  Future<List<CustomerEntity>> getAll() async {
    return dataProvider.getAll();
  }

  @override
  Future<bool> isEmailAvailable(String email) async {
    return dataProvider.isEmailAvailable(email);
  }

  @override
  Future<bool> isFirstNameLastNameAvailable(
    String firstName,
    String lastName,
  ) async {
    return dataProvider.isFirstNameLastNameAvailable(
      firstName,
      lastName,
    );
  }

  @override
  Future<void> update(CustomerEntity customer) {
    return dataProvider.update(customer);
  }
}
