import 'package:prestige_coach/main.dart';

class Repository {
  Future<List<Map<String, dynamic>>> getAvailableBuses(
      String source, String destination, String date, String time) async {
    final res = await supabase
        .from('location table')
        .select('*')
        .eq('startLocation', source)
        .eq('endLocation', destination)
        // .gte('dateColumnName', date)
        .gte('time', time);
    return res;
  }
}
