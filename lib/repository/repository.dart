import 'package:prestige_coach/main.dart';

class Repository {
  Future<List<Map<String, dynamic>>> getAvailableBuses(
      String source, String destination, String time) async {
    List<Map<String, dynamic>> filteredBuses = [];
    final res = await supabase
        .from('buses')
        .select('*, routes(*)')
        .eq('routes.start_location', source)
        .eq('routes.end_location', destination)
        .eq('time', time);
    print('this is $res');

    if (res[0]['routes'] != null || res[1]['routes'] != null) {
      final List<Map<String, dynamic>> buses = res;

      // Filter out entries where 'routes' is null
      filteredBuses = buses.where((bus) => bus['routes'] != null).toList();

      print('abc $filteredBuses');
      return filteredBuses;
    }
    return filteredBuses;
  }
}
