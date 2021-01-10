import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:provider/provider.dart';

import 'mytext.dart';
import 'strings.dart';
import 'dropdown.dart';
import 'book_ticket_model.dart';
import 'show.dart';

/// This class represents the UI of the home screen visible when the app starts
/// The data is fed to this screen through the model(ChangeValueNotifier)
class MovieTicketApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyMovieTicketPage(title: Strings.title),
    );
  }
}

class MyMovieTicketPage extends StatefulWidget {
  MyMovieTicketPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyMovieTicketPageState createState() => _MyMovieTicketPageState();
}


///This is where the UI is configured
class _MyMovieTicketPageState extends State<MyMovieTicketPage> {

  MyModel model;
  //List<Color> bookingStatus =  List<Color>();
  bool isInit = false;

  @override
   void initState(){
    super.initState();
    ///initialize data to be displayed when the app opens for the 1st time.
    model = Provider.of<MyModel>(context, listen: false);
    model.prepareShow(Strings.shows.first);
  }

  ///Books the selected ticket and displays the result in the bottom-sheet
   _onBook(){
      model.book();
      _showModalSheet(model.showObj.getTicket().getTicketStatus());
  }

  ///Displays the total sales of tickets across all the shows
  _onShowTotalSales(){
       model.showTotalSales();
       String totalSalesStatus = model.showObj.getTotalTicket().getTotalTicketReceipt();
      _showModalSheet(totalSalesStatus);
  }

  ///This method is called when we select a seat
  /// On seat selection, it changes the seat color to green
  _selectSeat(Seat seat){
    String name =  seat.getName();
    log('select seat $name' );

    ///Show appropriate message when we tap an already booked seat
    if(seat.getSeatStatus() == SeatStatus.Booked){
      log("Seat $name is already booked..");
      _showModalSheet("Seat $name already booked..");
      return;
    }
    setState(() {
      ///Change the color of the seat to green, if the seat is not booked
      ///and never selected before
      if(seat.getSeatStatus() == SeatStatus.Empty) {
        seat.updateSeatColor(SeatStatus.Selected);
        model.showObj.addSeat(seat);
      }

      ///Chage the color of the seat to white when we deselect the seat
      else if(seat.getSeatStatus() == SeatStatus.Selected){
        seat.updateSeatColor(SeatStatus.Empty);
        model.showObj.removeSeat(seat);
      }
    });

  }

  ///UI to display bottom sheet with [text] mentioned in the parameter
  void _showModalSheet(String text) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            child: MyText(text, 15, Colors.blue,
                FontWeight.bold, TextPadding(2, 2, 2, 2)),
            padding: EdgeInsets.fromLTRB( 10, 10, 5, 10),
          );
        });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Center(
            child: Column(
                children: [
                  ///Displays the movie name
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child:  MyText(Strings.movie, 15, Colors.red,
                        FontWeight.bold, TextPadding(20, 10, 20, 10))
                  ),
                  ///Displays the combo-box used to display the show
                  RoundedBorderDropdown(Strings.shows, Strings.showLabel, model),

                  ///Used to display text regarding show and auditorium
                  Consumer<MyModel>(
                    builder: (context, model, child) {
                      this.model = model;
                      Show s = model.showObj;

                        return MyText("Seats of ${s.getShowName()} in ${s.getAudi()}",
                            15, Colors.green, FontWeight.bold,
                            TextPadding(20, 10, 20, 10));

                    },
                  ),

                  ///Displays platinum seat title
                  showSeatTitle(SeatType.Platinum),
                  ///Displays Platinum seats
                  Consumer<MyModel>(
                    builder: (context, model, child) {
                      this.model = model;
                      return showSeats(SeatType.Platinum);
                    },
                  ),

                  ///Displays the title of Gold seats
                  showSeatTitle(SeatType.Gold),
                  ///Displays Gold seats
                  Consumer<MyModel>(
                    builder: (context, model, child) {
                      this.model = model;
                      return showSeats(SeatType.Gold);
                    },
                  ),

                  ///Displays Silver seats title
                  showSeatTitle(SeatType.Silver),
                  ///Displays Silver seats
                  Consumer<MyModel>(
                    builder: (context, model, child) {
                      this.model = model;
                      return showSeats(SeatType.Silver);
                    },
                  ),


                  /// Display [Book] and [Total Sales] Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getFlatButton(Strings.bookButtonText, _onBook),
                      getFlatButton(Strings.totalSalesButtonText, _onShowTotalSales),

                    ],
                  )


                ]
            )
        ),

    );
  }


  /// This method is used to create a seat and display it on the UI
  Widget showSeats(SeatType seatType){
    Show show = model.showObj;
    List seats;
    List <Widget> seatList = List<Widget>();
    var seatMap = Map<String, Seat>();
    if(seatType == SeatType.Platinum){
      seats = show.platinumSeats;
      seatMap = show.platinumSeatMap;
    }else if(seatType == SeatType.Silver){
      seats = show.silverSeats;
      seatMap = show.silverSeatMap;
    }else{
      seats = show.goldSeats;
      seatMap = show.goldSeatMap;
    }
    for(int i = 0; i < seats.length; i++){
      seatList.add( getSeat(seats[i]) );
    }
    Row seatRow = Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [],);

    for(int i = 0; i < seats.length; i++){
      seatRow.children.add(
          GestureDetector(
            onTap: () => _selectSeat(seatMap[seats[i]]),
            child: Container(
              child: seatList[i],
              decoration: BoxDecoration(
                color: seatMap[seats[i]].getSeatColor(),
                //color: bookingStatus[i],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 1.0, color: const Color(0xff707070)),
              ),
            ),
          )
      );
    }
    isInit = false;
    return seatRow;
  }

  Widget getSeat(String name){
    return MyText(name, 12, Colors.black, FontWeight.bold,
        TextPadding(3,3,3,3));
  }

  ///Responsible to display the Flat buttons on the screen
  Widget getFlatButton(String text, Function onTapFunction){
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: MyText(text, 15, Colors.white,
            FontWeight.bold, TextPadding(5, 5, 5, 5)),
        //child: Text('Book', style: TextStyle(fontSize: 20.0),),
        color: Colors.blueAccent,
        textColor: Colors.white,
        onPressed: onTapFunction,
      ),
    );
  }

  Widget showSeatTitle(SeatType seatType){

    return MyText(getSeatType(seatType), 15,
        getSeatTextColor(seatType), FontWeight.bold,
        TextPadding(20, 10, 20,10));
  }

  String getSeatType(SeatType seatType){
    String seatName = "";
    if(seatType == SeatType.Platinum){
      seatName = Strings.platinum;
    }else if(seatType == SeatType.Gold){
      seatName = Strings.gold;
    }else{
      seatName = Strings.silver;
    }
    return seatName;
  }

  Color getSeatTextColor(SeatType seatType){
    Color color;
    if(seatType == SeatType.Platinum){
      color = Color(0xffE5E4E2);
    }else if(seatType == SeatType.Gold){
      color =  Color(0xffFFD700);
    }else{
      color = Color(0xffC0C0C0);
    }
    return color;
  }


}
