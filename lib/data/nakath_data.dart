class NakathEvent {
  final String title;
  final String unicodeTitle; // For system notifications (Sinhala Unicode)
  final DateTime dateTime;

  NakathEvent({required this.title, required this.unicodeTitle, required this.dateTime});
}

final List<NakathEvent> nakathEvents = [
  NakathEvent(title: 'kj i| ne,Su', unicodeTitle: 'නව සඳ බැලීම', dateTime: DateTime(2026, 4, 19, 18, 0)), //nawa sanda balima
  NakathEvent(title: 'mrK wjqreoao i|yd iakdkh', unicodeTitle: 'පරණ අවුරුද්ද සඳහා ස්නානය', dateTime: DateTime(2026, 4, 10, 2, 30)), //parana aurudda sandaha snanaya kirima
  NakathEvent(title: 'w¨;a wjqreÿ Wodj', unicodeTitle: 'අලුත් අවුරුදු උදාව', dateTime: DateTime(2026, 4, 10, 10, 18)), //aluth aurudu udawa
  NakathEvent(title: 'mqKH ld,h', unicodeTitle: 'පුණ්‍ය කාලය', dateTime: DateTime(2026, 4, 10, 10, 05)), //punya kalaya
  NakathEvent(title: 'wdydr msiSu', unicodeTitle: 'ආහාර පිසීම', dateTime: DateTime(2026, 4, 10, 10, 30)), //ahara pisima
  NakathEvent(title: 'jev we,a,Su" .kqfokq lsÍu d wdydr wkqNjh', unicodeTitle: 'වැඩ ඇල්ලීම, ගනුදෙනු කිරීම හා ආහාර අනුභවය', dateTime: DateTime(2026, 4, 10, 10, 50)), //ahara anubawaya
  NakathEvent(title: 'ysi f;,a .Eu', unicodeTitle: 'හිස තෙල් ගෑම', dateTime: DateTime(2026, 4, 10, 11, 00)), //hisa thel gama
  NakathEvent(title: 'yÈis rdcldß i|yd msg;aj hdu', unicodeTitle: 'හදිසි රාජකාරී සඳහා පිටත්ව යාම', dateTime: DateTime(2026, 4, 10, 11, 18)), //hadisi rajakari sandaha pitathwa yama
  NakathEvent(title: '/lSrlaId i|yd msg;aùu', unicodeTitle: 'රැකියාව සඳහා පිටත්වීම', dateTime: DateTime(2026, 4, 10, 11, 30)), //rakiya sandaha pitath wima
];
