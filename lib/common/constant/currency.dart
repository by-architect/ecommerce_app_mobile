import '../ui/theme/AppText.dart';

enum Currency{

  usd(AppText.uSDollar, "USD", "\$", toLeft: true),
  vnd(AppText.vietnameseDong, "VND", "₫", toLeft: false),
  eur(AppText.euro, "EUR", "€", toLeft: true),
  inr(AppText.indianRupee, "INR", "₹", toLeft: true),
  jpy(AppText.japaneseYen, "JPY", "¥", toLeft: true),
  cny(AppText.chineseYuan, "CNY", "¥", toLeft: true),
  idr(AppText.indonesianRupiah, "IDR", "Rp", toLeft: true),
  myr(AppText.malaysianRinggit, "MYR", "RM", toLeft: true),
  php(AppText.philippinePeso, "PHP", "₱", toLeft: true),
  pln(AppText.polishZloty, "PLN", "zł", toLeft: false),
  rub(AppText.russianRuble, "RUB", "₽", toLeft: true),
  sek(AppText.swedishKrona, "SEK", "kr", toLeft: false),
  thb(AppText.thaiBaht, "THB", "฿", toLeft: true),
  tl(AppText.turkishLira, "TL", "₺", toLeft: false),
  ;


  final AppText name;
  final String short;
  final String sign;
  final bool toLeft;

  const Currency(this.name, this.short, this.sign, {required this.toLeft });


}