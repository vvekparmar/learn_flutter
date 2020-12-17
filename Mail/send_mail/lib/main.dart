import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

main() async {
  String username = 'prestigiousman1807@gmail.com';
  String password = 'dh@rmesh18';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username)
    ..recipients.add('vivekparmar393@gmail.com') //recipent email
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}' //subject of the email
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'; //body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n'+ e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
}