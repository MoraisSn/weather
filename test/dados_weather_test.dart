import 'package:test/test.dart';
import 'package:intl/intl.dart';
import '../lib/business_rule/get_wheater.dart';

void main() {
  test('Verifica se foi retornado um array de string', () async {
    const latitude  = -22.34440787318244; 
    const longitude = -49.1069327886562;
    String atualDate = DateTime.timestamp().toString();
    // final atualDate = DateFormat.yMMMMEEEEd().format(DateTime.timestamp());
    var getWeather = GetWeather();
    final getDadosTeste = await getWeather.getDadosJson(latitude,longitude,atualDate);
    expect(getDadosTeste,'Bauru');
  });
}
