void main() {
  // List of item prices in the cart
  List<double> itemPrices = [20.99, 15.50, 7.99, 49.99, 12.75];

  // Filter out items under $10 using an anonymous function
  List<double> filteredItems = itemPrices.where((price) => price >= 10).toList();
  print("Filtered items (>= \$10): $filteredItems");

  // Calculate the total before discounts and taxes
  double totalBeforeDiscount = calculateTotal(filteredItems);
  print('Total price before discounts and taxes: \$${totalBeforeDiscount.toStringAsFixed(2)}');

  // Apply a 10% discount using the applyDiscount function and a discount function
  double discountPercentage = 10;
  List<double> discountedPrices = applyDiscount(filteredItems, (price) => price - (price * discountPercentage / 100));
  print('Prices after ${discountPercentage}% discount: $discountedPrices');

  // Calculate the total after discount but before tax
  double totalAfterDiscount = calculateTotal(discountedPrices);
  print('Total price after discount but before tax: \$${totalAfterDiscount.toStringAsFixed(2)}');

  // Calculate tax at 8%
  double totalWithTax = calculateTotal(discountedPrices, taxRate: 0.08);
  print('Total price with tax: \$${totalWithTax.toStringAsFixed(2)}');

  // Apply a special factorial discount based on the number of items
  int itemCount = filteredItems.length;
  double factorialDiscountPercentage = calculateFactorialDiscount(itemCount);
  print('Factorial discount for $itemCount items: ${factorialDiscountPercentage}%');
  double finalTotal = totalWithTax - (totalWithTax * factorialDiscountPercentage / 100);
  print('Final price after applying factorial discount: \$${finalTotal.toStringAsFixed(2)}');
}

// Function to calculate the total price of items, with optional tax
double calculateTotal(List<double> prices, {double taxRate = 0.0}) {
  double total = prices.reduce((value, element) => value + element); // Sum of all prices
  total += total * taxRate; // Apply tax if any
  return total;
}

// Higher-order function to apply a discount
List<double> applyDiscount(List<double> prices, double Function(double) discountFunction) {
  return prices.map((price) => discountFunction(price)).toList();
}

// Recursive function to calculate factorial discount (e.g., for 4 items, return 4! = 24%)
double calculateFactorialDiscount(int n) {
  if (n <= 1) {
    return 1;
  } else {
    return n * calculateFactorialDiscount(n - 1);
  }
}

