import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neoclinic/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('NeoClinic app smoke test', (WidgetTester tester) async {
    GetStorage.init();
    await tester.pumpWidget(NeoClinicApp());
    expect(find.byType(NeoClinicApp), findsOneWidget);
  });
}
