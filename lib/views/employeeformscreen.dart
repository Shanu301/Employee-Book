import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/employee_controller.dart';
import '../models/employee.dart';

class AddUpdateEmployeeScreen extends StatelessWidget {
  final Employee? employee;
  final EmployeeController controller = Get.find<EmployeeController>();

  AddUpdateEmployeeScreen({this.employee});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();

  @override
  void initState() {
    if (employee != null) {
      _nameController.text = employee!.name;
      _ageController.text = employee!.age.toString();
      _salaryController.text = employee!.salary.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee != null ? 'Update Employee' : 'Add Employee'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a salary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final age = int.parse(_ageController.text);
                    final salary = double.parse(_salaryController.text);
                    if (employee != null) {
                      controller.updateEmployee(Employee(
                        id: employee!.id,
                        name: name,
                        age: age,
                        salary: salary,
                      ));
                    } else {
                      controller.addEmployee(Employee(
                        id: -1,
                        name: name,
                        age: age,
                        salary: salary,
                      ));
                    }
                  }
                },
                child: Text(employee != null ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}