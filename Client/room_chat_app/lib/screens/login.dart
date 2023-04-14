import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:room_chat_app/controller/socket_controller.dart';
import 'package:room_chat_app/screens/chat.dart';
import 'package:room_chat_app/widgets/custom_button.dart';

import '../widgets/custom_input_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  String? room;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    onSave: (val) {
                      room = val!;
                    },
                    mValidator: (val) {
                      if (val!.isEmpty) {
                        return 'Room is required';
                      }
                      return null;
                    },
                    type: 'phone',
                    obscure: false,
                    hint: 'Room',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    onSave: (val) {
                      name = val!;
                    },
                    mValidator: (val) {
                      if (val!.isEmpty) {
                        return 'username is required';
                      }
                      return null;
                    },
                    type: 'name',
                    obscure: false,
                    hint: 'username',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<SocketController>(
                    init: SocketController(),
                    builder: (socketController) => CustomButton(
                      width: MediaQuery.of(context).size.width / 2.5,
                      text: "Login",
                      color: Colors.blueAccent,
                      onPressed: () {
                        // Validation
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }

                        // emitting event to join the room
                        socketController.socket!
                            .emit('join', {"username": name, "room": room});

                        // Navigation to ChatScreen
                        Get.to(
                          ChatScreen(
                            room: room!,
                            username: name!,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
