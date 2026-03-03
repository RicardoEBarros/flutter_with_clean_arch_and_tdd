import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/fakes.dart';

final class EditUserViewModel {
  bool isNaturalPerson;

  EditUserViewModel({required this.isNaturalPerson});
}

final class EditUserPage extends StatelessWidget {
  final Future<EditUserViewModel> Function() loadUserData;
  const EditUserPage({super.key, required this.loadUserData});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EditUserViewModel>(
      future: loadUserData(),
      builder: (context, snapshot) {
        return Scaffold(
          body: Column(
            children: [
              RadioGroup(
                groupValue: snapshot.data?.isNaturalPerson,
                onChanged: (value) {},
                child: RadioListTile(value: true, title: Text('Pessoa Física')),
              ),
              RadioGroup(
                groupValue: snapshot.data?.isNaturalPerson,
                onChanged: (value) {},
                child: RadioListTile(value: false, title: Text('Pessoa Jurídica')),
              ),
            ],
          ),
        );
      },
    );
  }
}

final class LoadUserDataSpy {
  bool isCalled = false;
  var response = EditUserViewModel(isNaturalPerson: anyBool());

  Future<EditUserViewModel> call() async {
    isCalled = true;
    return response;
  }
}

void main() {
  testWidgets('should load user data on page init', (tester) async {
    final loadUserData = LoadUserDataSpy();
    final sut = MaterialApp(home: EditUserPage(loadUserData: loadUserData.call));
    await tester.pumpWidget(sut);
    expect(loadUserData.isCalled, true);
  });

  testWidgets('should check natural person', (tester) async {
    final loadUserData = LoadUserDataSpy();
    loadUserData.response = EditUserViewModel(isNaturalPerson: true);
    final sut = MaterialApp(home: EditUserPage(loadUserData: loadUserData.call));
    await tester.pumpWidget(sut);
    await tester.pump();
    expect(
      tester
          .widget<RadioGroup>(
            find.ancestor(
              of: find.ancestor(of: find.text('Pessoa Física'), matching: find.byType(RadioListTile<bool>)),
              matching: find.byType(RadioGroup<bool>),
            ),
          )
          .groupValue,
      true,
    );
  });
}
