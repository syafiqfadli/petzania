import 'dart:io';

import "package:flutter/material.dart";
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';

import '../../../../core/util/colors.dart';
import '../../../../core/widgets/base.dart';
import '../../../../core/widgets/input_field.dart';

class PetDetailsPage extends StatefulWidget {
  final PetEntity pet;
  const PetDetailsPage({super.key, required this.pet});

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  final TextEditingController _breedController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseWithScaffold(
      title: widget.pet.name.toUpperCase(),
      leftIcon: IconButton(
        icon: const Icon((Icons.arrow_back_ios_new)),
        onPressed: () {
          Navigator.of(context).pop();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 34,
      ),
      child: Expanded(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: widget.pet.image != null
                    ? Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(
                                File(widget.pet.image!),
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      )
                    : const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        foregroundColor: AppColor.defaultColor,
                        child: Text("No Image"),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 40,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Breed",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: width * 0.6,
                          child: InputFieldWidget(
                            textController: _breedController,
                            inputType: TextInputType.text,
                            hint: "Enter pet breed...",
                            isObscure: false,
                            onChanged: (String? value) {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
