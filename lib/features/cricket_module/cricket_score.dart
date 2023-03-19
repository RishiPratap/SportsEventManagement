import 'package:flutter/material.dart';

class CricketScore extends StatefulWidget {
  const CricketScore({Key? key}) : super(key: key);

  get btnVal => "0";
  @override
  State<CricketScore> createState() => _CricketScoreState();
}

class _CricketScoreState extends State<CricketScore> {
  final TextEditingController _searchInputControllor = TextEditingController();

  void appendCharacters() {
    String oldText = _searchInputControllor.text;
    String newText = oldText + widget.btnVal;

    var newValue = _searchInputControllor.value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
      composing: TextRange.empty,
    );

    _searchInputControllor.value = newValue;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: h,
          child: Stack(
            children: [
              Positioned(
                top: h * 0.08,
                left: w * 0.1,
                child: Text("<",
                    style: TextStyle(
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              _header(),
              // _score(),
              Positioned(
                top: h * 0.2,
                left: w * 0.6,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                  onPressed: () {
                    print("Match Result pressed");
                  },
                  child: Text(
                    "Match Result >",
                    // "Match Results >",
                    style: TextStyle(
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),

              Center(
                child: Expanded(
                  child: TextField(
                    enableInteractiveSelection: false,
                    controller: _searchInputControllor,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: w * 0.08),
                        hintText: "0/0",
                        labelText: "Score"),
                  ),
                ),
              ), //TODO edit this

              _score(), //TODO ADD SCORING PART
              Positioned(
                top: h * 0.42,
                left: w * 0.11,
                child: Text(
                  "Team A won the toss and elected to bat first",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              // _score(),
              _scoreCard(),
              _bowlerCard(),
              _keyBoard(),
              _keyBoard2(),
              _keyBoard3(),
              _submit(),
            ],
          ),
        ),
      ),
    );
  }

  _header() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.height;
    return Positioned(
      left: 0.08,
      right: 0.08,
      top: h * 0.11,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Text(
            "Team A",
            style: TextStyle(
                fontSize: w * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: TextButton(
            onPressed: () {
              print("Pressed");
            },
            child: Icon(
              Icons.settings,
              color: Colors.red,
              size: w * 0.05,
            ),
          ),
        ),
      ]),
    );
  }

  _score() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.27,
      left: w * 0.4,
      child: Row(
        children: [
        
          Container(
            margin: EdgeInsets.only(top: w * 0.02),
            child: Padding(
              padding: EdgeInsets.all(w * 0.02),
              child: Text("(0/8)",
                  style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  _scoreCard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.48,
      left: h * 0.02,
      right: w * 0.04,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
            width: w * 0.4,
            height: h * 0.07,
            child: ElevatedButton(
              child: const Text("Aniket Mudpe \n0(0)"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  ), backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4)),
              onPressed: () {
                print("Pressed");
              },
            )),
        SizedBox(
            width: w * 0.4,
            height: h * 0.07,
            child: ElevatedButton(
              child: const Text("Hiren Thacker\n0(0)"),
              style: ElevatedButton.styleFrom(
                  elevation: 5, backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.02),
                  )),
              onPressed: () {
                print("Pressed");
              },
            )),
      ]),
    );
  }

  _bowlerCard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.58,
      left: h * 0.03,
      right: w * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Jay Pokar",
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text(
            '0-0-0-0',
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  _keyBoard() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.65,
      left: w * 0.01,
      right: w * 0.01,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
        width: w * 0.2,
        height: w * 0.15,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ElevatedButton(
          child: const Text("0"),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              ), backgroundColor: Colors.red),
          onPressed: () {
            _searchInputControllor.text =
                _searchInputControllor.text + "0";
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("1"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            _searchInputControllor.text =
                _searchInputControllor.text + "1";
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("2"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            _searchInputControllor.text =
                _searchInputControllor.text + "2";
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("Undo"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
        ]),
    );
  }

  _keyBoard2() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.74,
      left: w * 0.01,
      right: w * 0.01,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("3"),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              ), backgroundColor: Colors.red),
          onPressed: () {
            print("Pressed");
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("4"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("6"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("5,7"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
        ]),
    );
  }

  _keyBoard3() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Positioned(
      top: h * 0.83,
      left: w * 0.01,
      right: w * 0.01,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("WD"),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              ), backgroundColor: Colors.red),
          onPressed: () {
            print("Pressed");
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("NB"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text("BYE"),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
          SizedBox(
        width: w * 0.2,
        height: w * 0.15,
        child: ElevatedButton(
          child: const Text(
            "Out",
            style: TextStyle(color: Colors.red),
          ),
          style: ElevatedButton.styleFrom(
              elevation: 5, backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.02),
              )),
          onPressed: () {
            print("Pressed");
          },
        )),
        ]),
    );
  }

  _submit() {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Positioned(
        top: h * 0.92,
        left: w * 0.2,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5, backgroundColor: const Color(0xFFD15858),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * 0.02),
                )),
            onPressed: () {},
            child: SizedBox(
                width: w * 0.442,
                height: w * 0.14,
                child: Padding(
                  padding: EdgeInsets.all(w * 0.03),
                  child: Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.05,
                    ),
                  ),
                )),
          ),
        ));
  }
}
