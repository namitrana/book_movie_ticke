import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'strings.dart';
import 'ticket.dart';

///Enum to identify whether the seat is booked, selected or unselected
enum SeatStatus{Empty, Selected, Booked}
///Enum to identify seat type
enum SeatType{Platinum, Gold, Silver}


/// This class is used to book tickets, generate total sales,
/// select/deselect tickets
class Show{

   static double totalSales = 0;
   Ticket ticket;
   static Ticket totalShowTicket =  new Ticket();
   int typeOfSeats = 3;

   ///For each show visited for the first time, set the seat status and color
   ///For the first time, all the seats are available shown in white color
   Show(){
    // log('show() new constructor');
     Seat seat;
     String s1, s2, s3;
     for(int i = 0; i < platinumSeats.length; i++){
       seat = new PlatinumSeat();
       seat.setName(platinumSeats[i]);
       seat.updateSeatColor(SeatStatus.Empty);
       //platinumSeatList.add(seat);
       platinumSeatMap[platinumSeats[i]] = seat;

       seat = new GoldSeat();
       seat.setName(goldSeats[i]);
       seat.updateSeatColor(SeatStatus.Empty);
       goldSeatMap[goldSeats[i]] = seat;

       seat = new SilverSeat();
       seat.setName(silverSeats[i]);
       seat.updateSeatColor(SeatStatus.Empty);
       silverSeatMap[silverSeats[i]] = seat;

       s1 = platinumSeats[i];
       s2 = silverSeats[i];
       s3 = goldSeats[i];
       //log( " $s1 " " $s2" " $s3");
     }

     int length = platinumSeatMap.length;

   }

   ///names of the seat
   List<String> platinumSeats = [
     "A1", "A2", "A3", "A4", "A5","A6", "A7", "A8", "A9"
   ];
   List<String> goldSeats = [
     "B1", "B2", "B3", "B4", "B5","B6", "B7", "B8", "B9"
   ];
   List<String> silverSeats = [
     "C1", "C2", "C3", "C4", "C5","C6", "C7", "C8", "C9"
   ];

   //list of selected seats
   List<Seat> selectedList = [];

   ///Seat selected for booking is added to this list
   void addSeat(Seat seat){
     selectedList.add(seat);
     int length = selectedList.length;
     log('lengtht of selected list: $length');
   }

   ///Seat unselected for booking is removed from the list
   void removeSeat(Seat seat){
     selectedList.remove(seat);
     int length = selectedList.length;
     log('lengtht of selected list: $length');
   }

   ///This method is used to book selected seats and change its color
   ///and seat status to booked
   void bookTicket(){
     ticket = new Ticket();
      if(selectedList.isEmpty){
        ticket.setTicketReceipt(Strings.ticketNotSelected);
        return;
      }
      double total = 0;
      for(var seat in selectedList){
          total += seat.getPrice();
          //seat.setSeatStatus(SeatStatus.Booked);
          seat.updateSeatColor(SeatStatus.Booked);
      }


      ticket.setTicketCost(total);
      ticket.calculate();
      ticket.print();
      selectedList.clear();
      totalSales += total;
   }

   ///Calculates total sales and generate receipt
   void generateTotalSales(){
     if(totalSales == 0){
       totalShowTicket.setTotalTicketReceipt(Strings.noTicketPurchased);
       return;
     }
     totalShowTicket.setTicketCost(totalSales);
     totalShowTicket.calculate();
     totalShowTicket.printTotalSales();
   }

   Ticket getTicket(){
     return ticket;
   }

   Ticket getTotalTicket(){
     return totalShowTicket;
   }



   var platinumSeatMap = Map<String, Seat>();
   var silverSeatMap = Map<String, Seat>();
   var goldSeatMap = Map<String, Seat>();



   List<String> bookedSeats = List<String>();


   bookSeat(List seats){
     for(var seat in seats) {
       if(!bookedSeats.contains(seat)) {
         bookedSeats.add(seat);
       }
     }
   }
   
   List<String> showNames = Strings.shows;

   String audi = "";
   String showName = "";
   setAudi(String show){
     audi = Strings.showScreenMap[show];
   }

   ///Returns the name of the auditorium where the show is running
   String getAudi(){
     return audi;
   }

   setShowName(String showName){
     this.showName = showName;
   }

   String getShowName(){
     return showName;
   }
}

///This class is used to represent a seat
abstract class Seat {
  ///updates seat color depending on its [status]
  void updateSeatColor(SeatStatus status);
  ///Set the name/seat_no of the seat
  void setName(String name);
  Color getSeatColor();
  String getName();
  double getPrice();
  SeatStatus getSeatStatus();
}

class PlatinumSeat implements Seat{

  double price = 320;
  String name;
  Color seatColor = Colors.white;
  static const String seatType = "Platinum";
  SeatStatus seatStatus;

  void setName(String name){
    this.name = name;
  }
  String getName(){
    return name;
  }

  double getPrice(){
    return price;
  }


  @override
  void updateSeatColor(SeatStatus status) {
    switch(status){
      case SeatStatus.Booked:
        seatColor = Colors.grey;
        seatStatus = SeatStatus.Booked;
        break;
      case SeatStatus.Empty:
        seatColor = Colors.white;
        seatStatus = SeatStatus.Empty;
        break;
      case SeatStatus.Selected:
        seatStatus = SeatStatus.Selected;
        seatColor = Colors.green;
        break;
      default:
        seatStatus = SeatStatus.Empty;
        seatColor = Colors.white;
    }
  }

  Color getSeatColor(){
    return seatColor;
  }

  SeatStatus getSeatStatus(){
    return seatStatus;
  }

}

class GoldSeat implements Seat{

  double price = 280;
  String name;
  Color seatColor = Colors.white;
  static const String seatType = "Gold";
  SeatStatus seatStatus;

  void setName(String name){
    this.name = name;
  }
  String getName(){
    return name;
  }

  double getPrice(){
    return price;
  }

  @override
  void updateSeatColor(SeatStatus status) {
    switch(status){
      case SeatStatus.Booked:
        seatColor = Colors.grey;
        seatStatus = SeatStatus.Booked;
        break;
      case SeatStatus.Empty:
        seatColor = Colors.white;
        seatStatus = SeatStatus.Empty;
        break;
      case SeatStatus.Selected:
        seatColor = Colors.green;
        seatStatus = SeatStatus.Selected;
        break;
      default:
        seatStatus = SeatStatus.Empty;
        seatColor = Colors.white;
    }
  }

  Color getSeatColor(){
    return seatColor;
  }
  SeatStatus getSeatStatus(){
    return seatStatus;
  }
 /* void setSeatStatus(SeatStatus seatStatus){
    this.seatStatus = seatStatus;
  }*/
}

class SilverSeat implements Seat{

  double price = 240;
  Color seatColor = Colors.white;
  String name = "";
  static const String seatType = "Silver";
  SeatStatus seatStatus;

  String getName(){
    return name;
  }

  double getPrice(){
    return price;
  }

  void setName(String name){
    this.name = name;
  }

  @override
  void updateSeatColor(SeatStatus status) {
    switch(status){
      case SeatStatus.Booked:
        seatColor = Colors.grey;
        seatStatus = SeatStatus.Booked;
        break;
      case SeatStatus.Empty:
        seatColor = Colors.white;
        seatStatus = SeatStatus.Empty;
        break;
      case SeatStatus.Selected:
        seatColor = Colors.green;
        seatStatus = SeatStatus.Selected;
        break;
      default:
        seatColor = Colors.white;
        seatStatus = SeatStatus.Empty;
    }
  }

  Color getSeatColor(){
    return seatColor;
  }

  SeatStatus getSeatStatus(){
    return seatStatus;
  }

}