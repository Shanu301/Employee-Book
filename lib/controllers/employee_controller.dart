import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/employee.dart';

class EmployeeController extends GetxController {
  RxList<Employee> employees = <Employee>[].obs;
  RxBool isLoading = false.obs;

@override
void onInit(){
  super.onInit();
  fetchEmployees();
}

  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
      if (response.statusCode == 200) {
        final data = response.body;
        final json = jsonDecode(data);
        final employeeList = json['data'] as List;
        employees.value = employeeList.map((e) => Employee(
          id: e['id'],
          name: e['employee_name'],
          age: e['employee_age'],
          salary: double.parse(e['employee_salary'].toString()),
        )).toList();
      }
    } finally {

      isLoading.value = false;
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse('https://dummy.restapiexample.com/api/v1/create'),
        body: {
          'name': employee.name,
          'salary': employee.salary.toString(),
          'age': employee.age.toString(),
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final generatedId = data['data']['id'];
        employee.id = generatedId;
        fetchEmployees();
        Get.back();
        Get.snackbar('Success', 'Employee added successfully.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add employee.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      isLoading.value = true;
      final response = await http.put(
        Uri.parse('https://dummy.restapiexample.com/api/v1/update/${employee.id}'),
        body: {
          'name': employee.name,
          'salary': employee.salary.toString(),
          'age': employee.age.toString(),
        },
      );
      if (response.statusCode == 200) {
        fetchEmployees();
        Get.back();
        Get.snackbar('Success', 'Employee updated successfully.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update employee.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      isLoading.value = true;
      final response = await http.delete(Uri.parse('https://dummy.restapiexample.com/api/v1/delete/$id'));
      if (response.statusCode == 200) {
        fetchEmployees();
        Get.snackbar('Success', 'Employee deleted successfully.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete employee.');
    } finally {
      isLoading.value = false;
    }
  }
}