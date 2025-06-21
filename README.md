# blood_donation

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

// Widget \_bloodDropDownButton() {
// return Consumer<AuthRepo>(
// builder: (context, provider, child) {
// final types = provider.bloodTypes;
// final items = types
// .map((e) => DropdownMenuItem(value: e, child: Text(e)))
// .toList();
// return DropdownButtonFormField(
// decoration: InputDecoration(
// filled: true,
// fillColor: Appcolor.lightGrey,
// enabledBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: const BorderSide(color: Appcolor.lightGrey),
// ),
// focusedBorder: OutlineInputBorder(
// borderSide: const BorderSide(color: Appcolor.lightGrey),
// borderRadius: BorderRadius.circular(10),
// ),
// errorBorder: OutlineInputBorder(
// borderRadius: BorderRadius.circular(10),
// borderSide: const BorderSide(color: Colors.red),
// ),
// ),
// items: items,
// onChanged: (value) => provider.setBloodType(value!),
// );
// },
// );
// }
