import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_rh/data/repositories/user_repository.dart';
import 'package:mobile_app_rh/data/widgers/custom_snackbars.dart';
import 'package:uuid/uuid.dart';

import '../models/user.dart';
import '../widgers/custom_loading.dart';

class UserController extends GetxController {
  final UserRepository _firestoreService = UserRepository();
  late RxString image, diplome, cv, contrat, cin, rib;

  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController cinController;
  late TextEditingController dobController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController ribController;
  //-------------------------------------  Professional Info  ------------------------------------------

  late TextEditingController degreeController;
  late TextEditingController positionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController salaryController;
  late TextEditingController workStartTimeController;
  late TextEditingController workEndTimeController;
  late TextEditingController breakTimeController;

  var uuid = Uuid();

  var users = <User>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    image = "".obs;
    diplome = "".obs;
    nameController = TextEditingController();
    surnameController = TextEditingController();
    cinController=TextEditingController();
    dobController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();
    ribController = TextEditingController();
    degreeController = TextEditingController();
    positionController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    salaryController = TextEditingController();
    workStartTimeController = TextEditingController();
    workEndTimeController = TextEditingController();
    breakTimeController = TextEditingController();
    cv = "".obs;
    contrat = "".obs;
    cin = "".obs;
    rib = "".obs;

    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      _firestoreService.getUsers().then((userList) {
        users.value = userList;
      });
    } finally {
      isLoading(false);
    }
  }

  addUser() async {
    try {
      if (image.value == "" ||
          rib.value == "" ||
          diplome.value == "" ||
          cv.value == "" ||
          contrat.value == "" ||
          cin.value == "") {
       await CustomSnackBars.error(
            icon: Icons.image,
            title: "Select image",
            message: "You must select image for the store");
        return;
      }

      /// START LOADING
      //CustomLoading.start();

      final imgUrl = await UserRepository.saveImage(
          imgName: uuid.v1(), imgPath: image.value);
      final ribUrl =
          await UserRepository.saveRib(ribName: uuid.v1(), ribPath: rib.value);
      final contratUrl = await UserRepository.saveContrat(
          contratName: uuid.v1(), contratPath: contrat.value);
      final diplomeUrl = await UserRepository.saveDiplome(
          diplomName: uuid.v1(), diplomePath: diplome.value);
      final cinUrl =
          await UserRepository.saveCin(cinName: uuid.v1(), cinPath: cin.value);
      final cvUrl =
          await UserRepository.saveCV(cvName: uuid.v1(), cvPath: cv.value);
      //isLoading(true);
      await _firestoreService.addUser(User(
        id: uuid.v1(),
        cin: cinController.text,
        cinFile: cinUrl,
        contratFile: contratUrl,
        cvFile: cvUrl,
        date: DateTime.now().toString(),
        diplomeFile: diplomeUrl,
        nom: nameController.text,
        email: emailController.text,
        poste: positionController.text,
        ribFile: ribUrl,
        ville: cityController.text,
        rib: ribController.text,
        salaire: salaryController.text,
        diplome: degreeController.text,
        imageFile: imgUrl,
        telephone: phoneController.text,
        prenom: surnameController.text,
        dateDeDebut: startDateController.text,
        hDebut: workStartTimeController.text,
        hFin: workEndTimeController.text,
        tPause: endDateController.text,
        typeContrat: "CDI",
      ));
      CustomLoading.stop();

      /// Men CREATED
      CustomSnackBars.success(title: "Successfully", message: "Men Added.");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      isLoading(true);

      await _firestoreService.updateUser(user);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      isLoading(true);
      await _firestoreService.deleteUser(id);
    } finally {
      isLoading(false);
    }
  }

  selectUserImage() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      image.value = file.files[0].path!;
    }
    CustomSnackBars.error(title: "Image Not Selected", message: "Try again");
  }

  selectDiplomeFile() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      diplome.value = file.files[0].path!;
    }
    CustomSnackBars.error(title: "File Not Selected", message: "Try again");
  }

  selectCvFile() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      cv.value = file.files[0].path!;
    }
    CustomSnackBars.error(title: "File Not Selected", message: "Try again");
  }

  selectContratFile() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      contrat.value = file.files[0].path!;
    }
    CustomSnackBars.error(title: "File Not Selected", message: "Try again");
  }

  selectCinFile() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      cin.value = file.files[0].path!;
    }
    CustomSnackBars.error(title: "File Not Selected", message: "Try again");
  }

  selectRibFile() async {
    FilePickerResult? file =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (file != null) {
      rib.value = file.files[0].path!;
    }
    CustomSnackBars.error(title: "File Not Selected", message: "Try again");
  }
}
