import 'dart:developer';

///This class is used to calculate and print booked tickets and total sales
class Ticket{

  ///All taxes in percentage
  final double serviceTax = 14;
  final double swachchhBharatCess = 0.5;
  final double krishiKalyanCess = 0.5;

  //booked ticket cost per show
  double ticketCost = 0;
  double serviceTaxCost = 0;
  double swachchhBharatCost = 0;
  double krishiKalyanCost = 0;

  //total sales cost
  double finalTicketCost = 0;

  String ticketReceipt = "";
  String totalTicketReceipt = "";

  ///Set booked ticket cost or total sales cost
  void setTicketCost(double ticketCost){
     this.ticketCost = ticketCost;
  }

  /// Calculate booked tickets and/or total sold tickets
  void calculate(){
      //calculate service tax
      serviceTaxCost = ticketCost * serviceTax / 100;
      serviceTaxCost = double.parse(serviceTaxCost.toStringAsFixed(2));
      //calculate swachchhBharat tax
      swachchhBharatCost = ticketCost * swachchhBharatCess / 100;
      swachchhBharatCost = double.parse(swachchhBharatCost.toStringAsFixed(2));
      //calculate KrishiKalyan tax
      krishiKalyanCost = ticketCost * krishiKalyanCess / 100;
      krishiKalyanCost = double.parse(krishiKalyanCost.toStringAsFixed(2));
      //calculate total cost
      finalTicketCost = ticketCost + serviceTaxCost +
          swachchhBharatCost + krishiKalyanCost;
      finalTicketCost = double.parse(finalTicketCost.toStringAsFixed(2));
  }

  ///Print booked ticket receipt
  void print(){
      log("The ticket has been booked successfully\n"
      "Subtotal: $ticketCost\n"
      "Service tax @ $serviceTax% is $serviceTaxCost\n"
          "KrishiKalyan @ $krishiKalyanCess% is $krishiKalyanCost\n"
          "SwachchhBharat @ $swachchhBharatCess% is $swachchhBharatCost\n"
          "Total cost is $finalTicketCost\n");

      String status = "The ticket has been booked successfully\n"
          "Subtotal: $ticketCost\n"
          "Service tax @ $serviceTax% is $serviceTaxCost\n"
          "KrishiKalyan @ $krishiKalyanCess% is $krishiKalyanCost\n"
          "SwachchhBharat @ $swachchhBharatCess% is $swachchhBharatCost\n"
          "Total cost is $finalTicketCost\n";

      setTicketReceipt(status);
  }

  ///Print total sales receipt
  void printTotalSales(){

    String status = "Total Sales of all Shows:\n"
        "Total Tiket Cost: $ticketCost\n"
        "Total Service tax @ $serviceTax% is $serviceTaxCost\n"
        "Total KrishiKalyan @ $krishiKalyanCess% is $krishiKalyanCost\n"
        "Total SwachchhBharat @ $swachchhBharatCess% is $swachchhBharatCost\n"
        "Total Cost Including Tax: $finalTicketCost\n";
        setTotalTicketReceipt(status);
  }

  setTicketReceipt(String status){
    ticketReceipt =  status;
  }

  String getTicketStatus(){
    return ticketReceipt;
  }

  setTotalTicketReceipt(String status){
    totalTicketReceipt =  status;
  }

  String getTotalTicketReceipt(){
    return totalTicketReceipt;
  }
}