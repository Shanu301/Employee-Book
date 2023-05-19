class Employee {
   int id;
   String name;
   int age;
   double salary;

  Employee({
    required this.id,
    required this.name,
    required this.age,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['employee_name'],
      age: json['employee_age'],
      salary: json['employee_salary'],
    );
  }
}