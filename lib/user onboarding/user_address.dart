import 'package:flutter/material.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}
class _DeliveryAddressState extends State<DeliveryAddress> {
  final _formKey = GlobalKey<FormState>();
final _addressController = TextEditingController();
@override
  void dispose() {
_addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
        title: const Text('Enter Address'), 
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Form(
          key: _formKey, 
          child: Column(
            children: [
              TextFormField(  controller: _addressController, 
                decoration: const InputDecoration(
                  labelText: 'Street Address', 
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a street address.'; 
                  }
                  return null; 
                },
              ),
              const SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Address submitted: ${_addressController.text}')),
                    );
                  }
                },
                child: const Text('Submit'), 
              ),
            ],
          ),
        ),
      ),
    );
  }
    
  }
