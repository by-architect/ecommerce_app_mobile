import '../ui/theme/AppText.dart';

enum Currency{

  usd(AppText.uSDollar, "USD", "\$"),
  vnd(AppText.vietnameseDong, "VND", "₫"),
  eur(AppText.euro, "EUR", "€"),
  inr(AppText.indianRupee, "INR", "₹"),
  jpy(AppText.japaneseYen, "JPY", "¥"),
  cny(AppText.chineseYuan, "CNY", "¥"),
  idr(AppText.indonesianRupiah, "IDR", "Rp"),
  myr(AppText.malaysianRinggit, "MYR", "RM"),
  php(AppText.philippinePeso, "PHP", "₱"),
  pln(AppText.polishZloty, "PLN", "zł"),
  rub(AppText.russianRuble, "RUB", "₽"),
  sek(AppText.swedishKrona, "SEK", "kr"),
  thb(AppText.thaiBaht, "THB", "฿"),
  try_(AppText.turkishLira, "TRY", "₺"),
  usd_(AppText.uSDollar, "USD", "\$"),
  vnd_(AppText.vietnameseDong, "VND", "₫"),
  eur_(AppText.euro, "EUR", "€"),
  inr_(AppText.indianRupee, "INR", "₹"),
  jpy_(AppText.japaneseYen, "JPY", "¥"),
  cny_(AppText.chineseYuan, "CNY", "¥"),
  idr_(AppText.indonesianRupiah, "IDR", "Rp"),
  myr_(AppText.malaysianRinggit, "MYR", "RM"),
  php_(AppText.philippinePeso, "PHP", "₱"),
  pln_(AppText.polishZloty, "PLN", "zł"),
  rub_(AppText.russianRuble, "RUB", "₽"),
  sek_(AppText.swedishKrona, "SEK", "kr");


  final AppText name;
  final String short;
  final String sign;

  const Currency(this.name, this.short, this.sign);


}