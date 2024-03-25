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

  Future<void> bookBus(
      int bus_id, int route_id, List selectedSeatNumber, String user_id, String date) async {
    final res = await supabase.from('booking').insert({
      'user_id':user_id,
      'date': date,
      'bus_id': bus_id,
      'route_id': route_id,
      'seat_number': selectedSeatNumber,
    });
  }

  Future<List> getUnavailableSeats(int bus_id, int route_id) async {
    final res = await supabase
        .from('booking')
        .select('seat_number')
        .eq('bus_id', bus_id)
        .eq('route_id', route_id);
    if (res[0]['seat_number'] != null) {
      final unavailableSeats =
          res.where((seatNumber) => seatNumber['seat_number'] != null).toList();
      print(unavailableSeats);
      return unavailableSeats;
    }
    return [];
  }
  Future<List<Map<String, dynamic>>> getTrips() async {
    final res = await supabase
        .from('booking')
        .select('*, buses(*), routes(*)');
    print (res);
  return res;
  }
}
