import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/employee_controller.dart';
import 'employeeformscreen.dart';

class MainScreen extends StatelessWidget {
  final EmployeeController controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Employee'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(AddUpdateEmployeeScreen());
            },
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.employees.length,
                itemBuilder: (context, index) {
                  final employee = controller.employees[index];
                  return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          side: BorderSide(width: 1, color: Colors.black)),
                      child: ListTile(
                          title: Text('Name: ${employee.name}',  style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900
                          )),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Age: ${employee.age}',  style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900
                              )),
                              Text('EmpID: ${employee.id}',  style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900
                              )),
                            ],
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row (
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(AddUpdateEmployeeScreen(employee: employee));
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Delete Employee'),
                                                content: Text('Are you sure you want to delete this employee?'),
                                                actions: [
                                                  TextButton(
                                                    child: Text('Cancel'),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text('Delete'),
                                                    onPressed: () {
                                                      controller.deleteEmployee(employee.id);
                                                      Get.back();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                  },
                                  child: Icon(Icons.delete,color: Colors.red,),
                                )
                              ]),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  '${employee.salary.toStringAsFixed(2)}',  style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w900
                              )),

                            ],
                          )


                          ));

                  //
                },
              ),
      ),
    );
  }
}
