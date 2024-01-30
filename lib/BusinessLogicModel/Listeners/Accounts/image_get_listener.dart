import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

class GetImage extends GetChangeNotifier
{
  var image;
  XFile? imageFile;
  late var imagePicker;
  ImageGetterEnums imageGetterEnums = ImageGetterEnums.nothing;

  GetImage()
  {
    imagePicker = ImagePicker();
  }
  void getImageFromGallery()
  async {
    try{
      imageFile = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
      getCroppedImage(imageFile);
    }catch(e){
      imageGetterEnums = ImageGetterEnums.nothing;
      notifyListeners();
    }
  }
  Future<Uint8List?> getBytesData(XFile? xFile)
  async {
    if(xFile!=null)
    {
      return await xFile.readAsBytes();
    }
    else
    {
      return null;
    }
  }
  void getImageFileData(XFile? xFile)
  {
    if(xFile!=null)
    {
      imageGetterEnums = ImageGetterEnums.show;
      image = File(xFile.path);
    }
    else
    {
      imageGetterEnums = ImageGetterEnums.nothing;
    }
    notifyListeners();
  }
  Future<void> getCroppedImage(XFile? xFile)
  async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: xFile?.path??'',
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Color(MyColor.colorPrimary),
              toolbarWidgetColor: Color(MyColor.colorWhite),
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false
          ),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
        ]
    );
    if (croppedFile != null) {
      imageGetterEnums = ImageGetterEnums.show;
      image = File(croppedFile.path);
    }
    else{
      imageGetterEnums = ImageGetterEnums.nothing;
    }
    notifyListeners();
  }
  Future<void> getLostData() async {
    if(Platform.isAndroid)
    {
      final LostDataResponse response =
      await imagePicker.retrieveLostData();
      if (response.isEmpty) {
        return;
      }
      if (response.files != null) {
        for(final XFile file in response.files!) {
          image = file;
        }
      } else {
        imageGetterEnums = ImageGetterEnums.nothing;
      }
      notifyListeners();
    }
  }
}
enum ImageGetterEnums
{
  nothing,show,urlImage
}