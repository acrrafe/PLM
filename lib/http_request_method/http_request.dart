import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// var url = Uri.parse('https://plm-scholarship-api.azurewebsites.net/applicants/$email');
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../home_student.dart';

class RemoteService {
  Future<Map<String, dynamic>> fetchData(String email) async {
    var url = Uri.parse(
        'https://plm-mobile-app-api.vercel.app/api/users/$email');
    print("EMAIL: $email");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("JSON RESPONSE: $jsonResponse");

      final applicant = jsonResponse['data'];
      final emailValue = applicant['email'];
      final firstNameValue = applicant['firstName'];
      final middleNameValue = applicant['middleName'];
      final lastNameValue = applicant['lastName'];
      final studentNumValue = applicant['studentNumber'];
      final collegeValue = applicant['college'];
      final courseValue = applicant['course'];
      final yearValue = applicant['year'].toString(); // Convert to String
      final mobileNumValue = applicant['mobileNumber'];
      final birthdateValue = applicant['birthdate'];
      final currentGwaValue = applicant['currentGwa'];

      // Parse the birthdate string into a DateTime object
      final birthdate = DateTime.parse(birthdateValue);

      // Format the birthdate in the desired format
      final formattedBirthdate = DateFormat('yyyy-MM-dd').format(birthdate);

      final data = {
        'email': emailValue,
        'firstName': firstNameValue,
        'middleName': middleNameValue,
        'lastName': lastNameValue,
        'studentNum': studentNumValue,
        'college': collegeValue,
        'course': courseValue,
        'year': yearValue,
        'mobileNum': mobileNumValue,
        'birthdate': formattedBirthdate,
        'currentGwa': currentGwaValue,
      };
      print("DATA: $data");
      return data;
    } else {
      // Handle the error case
      throw Exception('Failed to fetch data');
    }
  }

  Future<Map<String, dynamic>> addData(BuildContext context, String email, String firstName, String middleName,
      String lastName, String studentNum, String studentCollege, String studentCourse, int studentYear,
      String studentMobileNum, String birthDate, String currentGWA) async {
    var url = Uri.parse('https://plm-mobile-app-api.vercel.app/api/users');

    final requestData = {
      'email': email,
      'studentNumber': studentNum,
      'currentGwa': currentGWA,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'college': studentCollege,
      'course': studentCourse,
      'year': studentYear,
      'mobileNumber': studentMobileNum,
      'birthdate': birthDate,
    };
    print("REQUEST DATA: $requestData");
    final response = await http.post(
      url,
      body: json.encode(requestData),
      headers: {'Content-Type': 'application/json'},
    );
    final jsonResponseEncode = json.encode(requestData);
    print("JSONENCODE $jsonResponseEncode");

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("JSON RESPONSE: $jsonResponse");
      // Set flag to false
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(email, false);
      // Process the response data here
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: email)));

      return jsonResponse;
    } else {
      // Handle the error case
      throw Exception('Failed to add data');
    }
  }
  Future<Map<String, dynamic>> updateData(BuildContext context, String email, String firstName, String middleName,
      String lastName, String studentNum, String studentCollege, String studentCourse, int studentYear,
      String studentMobileNum, String birthDate, String currentGWA) async {
    var url = Uri.parse('https://plm-mobile-app-api.vercel.app/api/users');

    final requestData = {
      'email': email,
      'studentNumber': studentNum,
      'currentGwa': currentGWA,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'college': studentCollege,
      'course': studentCourse,
      'year': studentYear,
      'mobileNumber': studentMobileNum,
      'birthdate': birthDate,
    };
    print("REQUEST DATA: $requestData");
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestData),
    );
    final jsonResponseEncode = json.encode(requestData);
    print("JSONENCODE $jsonResponseEncode");

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print("JSON RESPONSE: $jsonResponse");
      // Process the response data here
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(text: email)));

      return jsonResponse;
    } else {
      // Handle the error case
      throw Exception('Failed to update data');
    }
  }

  Future<bool> checkUserExists(String email) async {
    var url = Uri.parse('https://plm-mobile-app-api.vercel.app/api/users/$email');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final applicant = jsonResponse['data'];

      return applicant != null; // Return true if the applicant exists
    } else if (response.statusCode == 404) {
      return false; // Return false if the applicant does not exist
    } else {
      // Handle other error cases
      throw Exception('Failed to check user existence');
    }
  }
}
