import 'dart:io';

String makeApiUrl(String path) => 'http://${Platform.isIOS ? '' : '192.168.18.5'}:8080/api/$path';
