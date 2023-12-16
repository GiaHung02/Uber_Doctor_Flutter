// String domain = 'http://192.168.31.40:8080/';

// School
String domain = 'http://192.168.1.13:8080/';   
// Home   
//  String domain = 'http://192.168.1.202:8080/';     





// -- auth
String loginDoctorAPI = domain + 'Uber_Doctor/api/v1/doctor/check/';
String loginPatientAPI = domain + 'Uber_Doctor/api/v1/patient/check/';

String registerPatientAPI = domain + 'Uber_Doctor/api/v1/patient/create';
String registerDoctorAPI = domain + 'Uber_Doctor/api/v1/doctor/create';

// String sendTokenAPI = domain + 'auth/send-token';
// String resetPassAPI = domain + 'auth/forget-password/change-password';

class Constants {
  static const String clientId =
      'AY8lTgaa8RjsHdb7GPorMqN7CVU648lR-9kABGNTltWd8sWwhd7wubAaf0V5E9QbQ0UYvjsG47WWQe6l';
  static const String secretKey =
      'ELIv-VhYhKjBGRiyMPmnaGGqxBFw6FXup2RU83nHVKnF0ZvPPzKHRwfIA4ZN4Z7tXCClSfzcWX6wE_i0';
  static const String returnURL = 'https://samplesite.com/return';
  static const String cancelURL = 'https://samplesite.com/cancel';
}

