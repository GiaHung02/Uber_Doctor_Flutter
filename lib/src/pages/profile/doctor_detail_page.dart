import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_doctor_flutter/src/api/doctor_api/doctor_api_service.dart';
import 'package:uber_doctor_flutter/src/model/doctor.dart';
import 'package:uber_doctor_flutter/src/theme/theme.dart';

class DoctorDetailPage extends StatelessWidget {
  final List<Doctor> doctors;
  final int selectedIndex;

  DoctorDetailPage({
    Key? key,
    required this.doctors,
    required this.selectedIndex,
  }) : super(key: key);

  Future<Doctor> _fetchDoctorDetails() async {
    final int selectedIndex = this.selectedIndex;
    final List<Doctor> doctors = this.doctors;
    try {
      return DoctorService.getDoctorByID(doctors[selectedIndex].id!);
    } catch (error) {
      print('Error fetching doctor details: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorService());
    Doctor data = Get.arguments;

    controller.phoneNumber.text = data.phoneNumber!;
    controller.fullName.text = data.fullName!;
    controller.email.text = data.email!;
    controller.bankingAccount.text = data.bankingAccount!;
    controller.imagePath.text = data.imagePath!;
    controller.address.text = data.address!;
    controller.accepted.text = data.accepted! as String;
    controller.status.text = data.status! as String;
    controller.spectiality.text = data.spectiality!;
    controller.rate.text = data.rate! as String;
    controller.price.text = data.price! as String;
    controller.exp.text = data.exp! as String;
    controller.wallet.text = data.wallet! as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Details'),
      ),
      body: FutureBuilder(
        future: _fetchDoctorDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            Doctor selectedDoctor = snapshot.data as Doctor;
            return Form(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedDoctor.imagePath != null)
                        Image.network(
                          "$domain:8080/${selectedDoctor.imagePath!}",
                          height: 100,
                          width: 100,
                        ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        controller: controller.fullName,
                        initialValue: selectedDoctor.fullName,
                        decoration: InputDecoration(labelText: 'Full Name'),
                        onChanged: (String fullName) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        controller: controller.phoneNumber,
                        initialValue: selectedDoctor.phoneNumber,
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        onChanged: (String phoneNumber) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.email,
                        initialValue: selectedDoctor.email?.toString() ?? '',
                        decoration: InputDecoration(labelText: 'Email'),
                        onChanged: (String email) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        controller: controller.bankingAccount,
                        initialValue: selectedDoctor.bankingAccount,
                        decoration:
                            InputDecoration(labelText: 'Banking Account'),
                        onChanged: (String bankingAccount) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        controller: controller.address,
                        initialValue: selectedDoctor.address,
                        decoration: InputDecoration(labelText: 'Address'),
                        onChanged: (String address) {},
                      ),
                      Row(
                        children: [
                          Text('Accepted'),
                          Checkbox(
                            value: selectedDoctor.accepted ?? false,
                            onChanged: (bool? newValue) {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Status'),
                          Checkbox(
                            value: selectedDoctor.status ?? false,
                            onChanged: (bool? newValue) {},
                          ),
                        ],
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        controller: controller.spectiality,
                        initialValue: selectedDoctor.spectiality,
                        decoration: InputDecoration(labelText: 'Speciality'),
                        onChanged: (String spectiality) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: controller.exp,
                        initialValue: selectedDoctor.exp?.toString() ?? '',
                        decoration:
                            InputDecoration(labelText: 'Years of Experience'),
                        onChanged: (String? exp) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: controller.rate,
                        initialValue: selectedDoctor.rate?.toString() ?? '',
                        decoration: InputDecoration(labelText: 'Rate'),
                        onChanged: (String rate) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: controller.price,
                        initialValue: selectedDoctor.price?.toString() ?? '',
                        decoration: InputDecoration(labelText: 'Price'),
                        onChanged: (String price) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        controller: controller.wallet,
                        initialValue: selectedDoctor.wallet?.toString() ?? '',
                        decoration: InputDecoration(labelText: 'Wallet'),
                        onChanged: (String wallet) {},
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        controller: controller.description,
                        initialValue: selectedDoctor.description,
                        decoration: InputDecoration(labelText: 'Description'),
                        onChanged: (String description) {},
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {
                            late Doctor updateDoctor;
                            if (controller.imagePath != null) {
                              updateDoctor = Doctor(
                                fullName: controller.fullName.text,
                                phoneNumber: controller.phoneNumber.text,
                                email: controller.email.text,
                                bankingAccount: controller.bankingAccount.text,
                                imagePath: data.imagePath!,
                                address: controller.address.text,
                                accepted: bool.parse(controller.accepted.text),
                                status: bool.parse(controller.status.text),
                                spectiality: controller.spectiality.text,
                                rate: int.parse(controller.rate.text),
                                price: double.parse(controller.price.text),
                                exp: int.parse(controller.exp.text),
                                description: controller.description.text,
                                wallet: double.parse(controller.wallet.text),
                              );
                            } else {
                              updateDoctor = Doctor(
                                fullName: controller.fullName.text,
                                phoneNumber: controller.phoneNumber.text,
                                email: controller.email.text,
                                bankingAccount: controller.bankingAccount.text,
                                imagePath: data.imagePath,
                                address: controller.address.text,
                                accepted: bool.parse(controller.accepted.text),
                                status: bool.parse(controller.status.text),
                                spectiality: controller.spectiality.text,
                                rate: int.parse(controller.rate.text),
                                price: double.parse(controller.price.text),
                                exp: int.parse(controller.exp.text),
                                description: controller.description.text,
                                wallet: double.parse(controller.wallet.text),
                              );
                            }
                            DoctorService.updateDoctor(updateDoctor, context);
                          }
                          // await _fetchUpdateDoctorInformation(
                          //   selectedDoctor,
                          //   selectedDoctor.id!,
                          // );
                        },
                        child: Text('Update Doctor Information'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
