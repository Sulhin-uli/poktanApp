import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:poktan_app/app/modules/petani/controllers/petani_controller.dart';

class AddPetaniView extends GetView<PetaniController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Tambah Poktan',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        elevation: 0.5,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nama",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.name,
                cursorColor: const Color(0xff16A085),
                decoration: const InputDecoration(
                  // helperText: 'Contoh: Label',
                  // fillColor: Color(0xff919A92),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff919A92),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff16A085),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Email",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              TextFormField(
                controller: controller.email,
                cursorColor: const Color(0xff16A085),
                decoration: const InputDecoration(
                  // helperText: 'Contoh: Label',
                  // fillColor: Color(0xff919A92),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff919A92),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff16A085),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Password",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  cursorColor: const Color(0xff16A085),
                  obscureText: controller.hiddenTextPassword.value,
                  decoration: InputDecoration(
                    // fillColor: Color(0xff919A92),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff919A92),
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff16A085),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hiddenTextPassword.toggle(),
                      icon: controller.hiddenTextPassword.isTrue
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: Color(0xff16A085),
                            )
                          : const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Color(0xff16A085),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Konfirmasi Password",
                style: TextStyle(
                  color: Color(0xff919A92),
                ),
              ),
              Obx(
                () => TextFormField(
                  controller: controller.password2,
                  cursorColor: const Color(0xff16A085),
                  obscureText: controller.hiddenTextPassword2.value,
                  decoration: InputDecoration(
                    // fillColor: Color(0xff919A92),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff919A92),
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff16A085),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => controller.hiddenTextPassword2.toggle(),
                      icon: controller.hiddenTextPassword2.isTrue
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: Color(0xff16A085),
                            )
                          : const Icon(
                              Icons.remove_red_eye_outlined,
                              color: Color(0xff16A085),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  height: 46, //height of button
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff16A085), // background
                    ),
                    onPressed: () => controller.postData(
                        controller.name.text,
                        controller.email.text,
                        controller.password.text,
                        controller.password2.text),
                    child: const Text('Tambah'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
