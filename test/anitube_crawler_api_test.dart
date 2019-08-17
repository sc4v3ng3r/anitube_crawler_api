import 'package:flutter_test/flutter_test.dart';

import 'package:anitube_crawler_api/anitube_crawler_api.dart';

void main() async {
  var api = AniTubeApi();

  //var homePage = await api.getHomePageData();
//  await api.getGenresAvailable();

  var homePage = await api.getHomePageData();
  
  homePage.mostShowedAnimes.forEach( print );

  //homePage.mostRecentAnimes.forEach(print);

  //print(data);
  //  test('adds one to input values', () {
//    final calculator = Calculator();
//    expect(calculator.addOne(2), 3);
//    expect(calculator.addOne(-7), -6);
//    expect(calculator.addOne(0), 1);
//    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
//  });
}
