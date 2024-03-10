import 'package:customer_management/domain/entity/customer.dart';

abstract class CustomerRepository {
  Future<CustomerEntity?> get(String id);
  Future<List<CustomerEntity>> getAll();
  Future<void> add(CustomerEntity customer);
  Future<void> update(CustomerEntity customer);
  Future<bool> isEmailAvailable(String email);
  Future<bool> isFirstNameLastNameAvailable(
    String firstName,
    String lastName,
  );
}
