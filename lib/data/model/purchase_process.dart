class PurchaseProcess {
  final String id;
  final String uid;
  final List<PurchaseProcess> processes;
  final String productId;
  final String subProductId;
  final int quantity;
  final String cargoNo;

  PurchaseProcess(
      {required this.id,
      required this.uid,
      required this.processes,
      required this.productId,
      required this.subProductId,
      required this.quantity,
      required this.cargoNo});
}

class PurchaseStatus {
  final PurchaseStatusType statusType;
  final DateTime dateTime;

  PurchaseStatus(this.statusType, this.dateTime);
}

enum PurchaseStatusType {
  onCart, //sepette
 //ödemeye başlandı,
 //ödeme sitesi açıldı (ödeme sitesinden işlem id al)
 //ödeme başarılı veya başarısız (eğer daha sonra ödeme zaman aşımına uğrarsa veya bir hata olursa işlem idyi tekrar sorgula ve işlemin gerçekleşip gerçekleşmediğini algıla)
  paid, // ödendi
  orderTaken, //sipariş alındı
  shipped, //kargolandı
  delivered, //ulaştı
  canceled,
  returnStarted, //iade başladı
  returnDelivered,
  returned,
  ;
}
