// import 'package:flutter/material.dart';
// import 'package:uber_doctor_flutter/src/api/doctor_api/doctor_api_service.dart';
// import 'package:uber_doctor_flutter/src/model/doctor.dart';

// class DoctorProfile extends StatefulWidget {
//   const DoctorProfile({
//     super.key,
//     required this.doctorID,
//   });

//   final int doctorID;

//   @override
//   State<DoctorProfile> createState() {
//     // TODO: implement createState
//     return _DoctorProfileState();
//   }
// }

// class _DoctorProfileState extends State<DoctorProfile> {
//   late Future<Doctor> _doctor;

//   @override
//   void initState() {
//     super.initState();
//     _doctor = DoctorService.getDoctorByID(widget.doctorID);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product Details'),
//       ),
//       body: FutureBuilder<Doctor>(
//         future: _doctor,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final doctor = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('ID: ${doctor.id}'),
//                   TextFormField(
//                     initialValue: doctor.id.toString(),
//                     // onChanged: (value) {
//                     //   doctor.name = value;
//                     // },
//                     decoration: InputDecoration(labelText: 'Doctor ID'),
//                   ),
//                   TextFormField(
//                     initialValue: doctor.price.toString(),
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {
//                       doctor.price = double.tryParse(value) ?? 0.0;
//                     },
//                     decoration: InputDecoration(labelText: 'Product Price'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await DoctorService.updateDoctor(doctor);
//                       // Add navigation or other logic after updating
//                     },
//                     child: Text('Update Product'),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
