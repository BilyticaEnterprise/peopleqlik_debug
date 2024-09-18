# peopleqlik_debug

PeopleQlik app by Bilytica

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

For testing profile mode please use the following commands in terminal:

For PeopleQlik: [ flutter run —profile -t lib/commonApps/peopleqlik.dart --flavor peopleqlik ]

For release bundle please use the following commands in terminal:

flutter build apk --flavor peopleqlik -t lib/commonApps/peopleqlik.dart --debug

For PeopleQlik Bundle run: [ flutter build appbundle --flavor peopleqlik -t lib/commonApps/peopleqlik.dart ]
For PeopleQlik Apk run : [ flutter build apk --flavor peopleqlik -t lib/commonApps/peopleqlik.dart ]
For Ojoor: [ flutter build appbundle --flavor ojoor -t lib/commonApps/ojoor.dart ]