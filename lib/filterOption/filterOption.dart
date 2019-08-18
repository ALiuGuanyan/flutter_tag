import 'package:flutter/material.dart';

class FilterOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Google IO Filter Demo"),
        ),
        body: FilterOptionWidget(),
      ),
    );
  }
}


class FilterOptionWidget extends StatefulWidget  {



  @override
  _FilterOptionWidgetState createState() => _FilterOptionWidgetState();


}

class _FilterOptionWidgetState extends State<FilterOptionWidget> with SingleTickerProviderStateMixin {
  final GlobalKey _parentContainer = GlobalKey(debugLabel: 'parent container');

  AnimationController _animationController;
  Animation<double> _textLeftPaddingAnimation;
  Animation<double> _textRightPaddingAnimation;
  Animation<double> _closeIconAnimation;
  Animation<double> _dotHeightAnimation;
  Animation<double> _dotTopPositionAnimation;
  Animation<double> _dotLeftPositionAnimation;
  Animation<Color> _textColorAnimation;
  Animation<Color> _backgroundColorAnimation;
  Animation<double> _borderWidthAnimation;

  bool get animationStatus {
    AnimationStatus status = _animationController.status;
    return status == AnimationStatus.completed;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _textLeftPaddingAnimation = Tween<double>(
      begin: 23.0,
      end: 10.0,
    ).animate(_animationController);

    _textRightPaddingAnimation = Tween<double>(
      begin: 10.0,
      end: 25.0,
    ).animate(_animationController);

    _closeIconAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _dotHeightAnimation = Tween<double>(
      begin: 10.0,
      end: 25.0,
    ).animate(_animationController);

    _dotTopPositionAnimation = Tween<double>(
      begin: 6.5,
      end: 0.0,
    ).animate(_animationController);

    _dotLeftPositionAnimation = Tween<double>(
      begin: 8.0,
      end: 0.0,
    ).animate(_animationController);

    _textColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(_animationController);

    _backgroundColorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.blue.withOpacity(.8),
    ).animate(_animationController);

    _borderWidthAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_animationController);
  }

  Animation<double> getDotWidth() {
    var width = 10.0;
    if (_parentContainer.currentContext != null) {
      final RenderBox renderBox = _parentContainer.currentContext.findRenderObject();
      width = renderBox.size.width;
    }
    return Tween<double>(
      begin: 10.0,
      end: width,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget getWidget(BuildContext context, Widget widget) {
    return Center(
      child: InkWell(
        onTap: () {
          animationStatus ? _animationController.reverse() : _animationController.forward();
        },
        splashColor: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.all(Radius.circular(20.0),),
        child: Container(
          key: _parentContainer,
          height: 25.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(
              color: Colors.black12,
              width: _borderWidthAnimation.value,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: _dotLeftPositionAnimation.value,
                top: _dotTopPositionAnimation.value,
                child: Container(
                  height: _dotHeightAnimation.value,
                  width: getDotWidth().value,
                  decoration: BoxDecoration(
                    color: _backgroundColorAnimation.value,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                widthFactor: 1.0,
                child: Container(
                  padding: EdgeInsets.only(
                    left: _textLeftPaddingAnimation.value,
                    right: _textRightPaddingAnimation.value,
                  ),
                  child: Text(
                    "Filter Unselected",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _textColorAnimation.value,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 5.0,
                top: 5.5,
                child: Center(
                  child: ScaleTransition(
                    scale: _closeIconAnimation,
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: getWidget,
    );
  }
}
