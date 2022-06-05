import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poktan_app/app/modules/petani/controllers/petani_controller.dart';

class DetailPetaniView extends GetView<PetaniController> {
  @override
  Widget build(BuildContext context) {
    final data = controller.findByid(Get.arguments);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Detail Poktan',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        leading: const BackButton(color: Colors.black),
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.startupdonut.co.uk/sites/default/files/styles/landing_pages_lists/public/Guy_watson_249x167.png?itok=e_ct04Rx'),
                ),
                title: Text(data.userId!.name!),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: const Text(
                  "Title",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Column",
                          style: TextStyle(
                            color: Color(0xff919A92),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          "Value",
                          style: TextStyle(
                            color: Color(0xff919A92),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xff919A92),
                    ),
                    Row(
                      children: const [
                        Text(
                          "Column",
                          style: TextStyle(
                            color: Color(0xff919A92),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          "Value",
                          style: TextStyle(
                            color: Color(0xff919A92),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xff919A92),
                    ),
                    Row(
                      children: const [
                        Text(
                          "Column",
                          style: TextStyle(
                            color: Color(0xff919A92),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          "Value",
                          style: TextStyle(
                            color: Color(0xff919A92),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xff919A92),
                    ),
                    Container(
                      height: 200,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
