import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_frontend/main.dart';

void main() {
  testWidgets('Login screen renders key elements', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Title
    expect(find.text('Login'), findsOneWidget);

    // Labels
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Buttons
    expect(find.text('Login'), findsWidgets); // title + button label
    expect(find.text('Login with Google'), findsOneWidget);
    expect(find.text('Login with Appe'), findsOneWidget);

    // Footer
    expect(find.text('Don’t have an account? Register'), findsOneWidget);
  });
}
