import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class BecomeSellerWidget extends StatelessWidget {
  const BecomeSellerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 40,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              "Become a Seller",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You can also sell on our app. Join us and start selling your products easily.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to ApplyNowPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplyNowPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Apply Now"),
            ),
          ],
        ),
      ),
    );
  }
}

class BecomeDriverWidget extends StatelessWidget {
  const BecomeDriverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.directions_car_outlined,
              size: 40,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              "Become a Driver",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Join our network as a driver and start earning by delivering with us.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to ApplyNowPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DriverApplyNowPage()),
                );
              },
              child: const Text("Apply Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//applay now page starts here

class ApplyNowPage extends StatefulWidget {
  @override
  _ApplyNowPageState createState() => _ApplyNowPageState();
}

class _ApplyNowPageState extends State<ApplyNowPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _businessDescriptionController =
      TextEditingController();

  bool _termsAccepted = false;

  Future<void> _submitApplication() async {
    final url = Uri.parse(
        'https://your-api-endpoint.com/applications'); // Replace with your API endpoint

    final body = {
      'firstName': _firstNameController.text,
      'surname': _surnameController.text,
      'nationalId': _nationalIdController.text,
      'businessName': _businessNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'address': _addressController.text,
      'businessDescription': _businessDescriptionController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully!')),
        );
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to submit application: ${response.body}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _surnameController.clear();
    _nationalIdController.clear();
    _businessNameController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _businessDescriptionController.clear();
    setState(() {
      _termsAccepted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Seller'),
        centerTitle: true,
        backgroundColor: Colors.orange, // Header color set to orange
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Surname
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your surname';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // National ID
              TextFormField(
                controller: _nationalIdController,
                decoration: const InputDecoration(
                  labelText: 'National ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your National ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Business Name
              TextFormField(
                controller: _businessNameController,
                decoration: const InputDecoration(
                  labelText: 'Business Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Business Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Phone Number
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Business Description
              TextFormField(
                controller: _businessDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Business Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your business';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Accept Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I accept the terms and conditions',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              if (!_termsAccepted)
                const Text(
                  'You must accept the terms and conditions',
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              const SizedBox(height: 16.0),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _termsAccepted) {
                      _submitApplication();
                    } else if (!_termsAccepted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'You must accept the terms and conditions')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color set to green
                  ),
                  child: const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// drivers form



class DriverApplyNowPage extends StatefulWidget {
  @override
  _DriverApplyNowPageState createState() => _DriverApplyNowPageState();
}

class _DriverApplyNowPageState extends State<DriverApplyNowPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _driverLicenseNumberController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _businessDescriptionController = TextEditingController();

  File? _carImage;

  bool _termsAccepted = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _carImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitApplication() async {
    final url = Uri.parse('https://your-api-endpoint.com/applications'); // Replace with your API endpoint

    final body = {
      'firstName': _firstNameController.text,
      'surname': _surnameController.text,
      'nationalId': _nationalIdController.text,
      'registrationNumber': _registrationNumberController.text,
      'driverLicenseNumber': _driverLicenseNumberController.text,
      'phoneNumber': _phoneNumberController.text,
      'address': _addressController.text,
      'businessDescription': _businessDescriptionController.text,
    };

    try {
      final request = http.MultipartRequest('POST', url);
      body.forEach((key, value) {
        request.fields[key] = value;
      });

      if (_carImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('carImage', _carImage!.path),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully!')),
        );
        _clearForm();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit application: ${response.reasonPhrase}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _surnameController.clear();
    _registrationNumberController.clear();
    _nationalIdController.clear();
    _driverLicenseNumberController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _businessDescriptionController.clear();
    setState(() {
      _carImage = null;
      _termsAccepted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Driver'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Surname
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your surname';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // National ID
              TextFormField(
                controller: _nationalIdController,
                decoration: const InputDecoration(
                  labelText: 'National ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your National ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Registration Number
              TextFormField(
                controller: _registrationNumberController,
                decoration: const InputDecoration(
                  labelText: 'Registration Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle registration number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Driver License Number
              TextFormField(
                controller: _driverLicenseNumberController,
                decoration: const InputDecoration(
                  labelText: 'Driver License Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your driver license number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Upload Car Image
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ],
              ),
              if (_carImage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Image.file(
                    _carImage!,
                    width: 200,
                    height: 200,
                  ),
                ),
              const SizedBox(height: 16.0),

              // Accept Terms and Conditions
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _termsAccepted = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I accept the terms and conditions',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              if (!_termsAccepted)
                const Text(
                  'You must accept the terms and conditions',
                  style: TextStyle(color: Colors.red, fontSize: 12.0),
                ),
              const SizedBox(height: 16.0),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && _termsAccepted) {
                      _submitApplication();
                    } else if (!_termsAccepted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Accept the terms')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
