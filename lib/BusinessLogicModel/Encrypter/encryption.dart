
import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt.dart';
import 'package:intl/intl.dart';

class EncryptNow
{
  var ENCRYPTION_KEY = '4512631236589784';
  var ENCRYPTION_IV = '4512631236589784';

  String redirectToPayPeople(String token) {
    var queryString = '';
    var currTime = '';
    final now = DateTime.now().add(Duration(minutes: 5));
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
    currTime = dateFormat.format(now);
    queryString = '$token\$\$$currTime\$\$pms\$\$mobile';

    final key = Key.fromUtf8('4512631236589784');
    final iv = IV.fromUtf8('4512631236589784');
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc,padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(queryString,iv: iv);

    final payPeopleUrl = 'https://app.paypeople.pk/#/login?id='; // Replace this with the actual URL
    queryString = payPeopleUrl + Uri.encodeComponent(encrypted.base64).toString();

    return queryString;
  }

  Future<String> encryption(String plainText) async {
    final key = Key.fromUtf8(ENCRYPTION_KEY);
    final iv = IV.fromUtf8(ENCRYPTION_IV);

    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    return encrypted.base64;
  }

  List<int> _fromHex(String s) {
    s = s.replaceAll(' ', '').replaceAll('\n', '');
    return List<int>.generate(s.length ~/ 2, (i) {
      var byteInHex = s.substring(2 * i, 2 * i + 2);
      if (byteInHex.startsWith('0')) {
        byteInHex = byteInHex.substring(1);
      }
      final result = int.tryParse(byteInHex, radix: 16);
      if (result == null) {
        throw StateError('Not valid hexadecimal bytes: $s');
      }
      return result;
    });
  }

  // String decryption(String plainText) {
  //
  //   // final key = Key.fromUtf8(ENCRYPTION_KEY);
  //   // final iv = IV.fromUtf8(ENCRYPTION_IV);
  //   //
  //   // final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  //   // final decrypted = encrypter.decrypt(Encrypted.from64(plainText), iv: iv);
  //   //
  //   // return decrypted;
  // }
}