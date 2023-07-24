library customer;

import 'package:flutter/material.dart';
import 'package:mentallance/services/task_assignment.dart';

import '../../../components/reusable_widgets/reusable_button.dart';

import 'add_customer.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                    context, 'YENİ DANISAN Ekle',  () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddClient(),
                      ));
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                    context, 'gorev ekleme ekrani',  () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyWidget(),
                      ));
                }),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
