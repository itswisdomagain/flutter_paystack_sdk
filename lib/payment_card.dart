class PaymentCard {
  String cardNumber;
  String cvc;
  int expiryMonth;
  int expiryYear;

  PaymentCard(String cardNumber, String cvc, int expiryMonth, int expiryYear) {
    this.cardNumber = cardNumber;
    this.cvc = cvc;
    this.expiryMonth = expiryMonth;
    this.expiryYear = expiryYear;
  }
}