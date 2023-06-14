import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp is a StatefulWidget. This allows updating the state of the
// widget when an item is removed.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');
  double f = 0;
  @override
  Widget build(BuildContext context) {
    const title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              onResize: () {
                print('resize');
              },
              onUpdate: (v) {
                f = v.progress;
                print('update ${v.progress}');
                setState(() {});
              },
              key: Key(item),
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  items.removeAt(index);
                });

                // Then show a snackbar.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item dismissed')));
              },
              background: ColoredBox(
                color: Colors.green,
                child: Row(
                  children: [
                    SizedBox(
                      width: f * MediaQuery.of(context).size.width - 24 * 3 > 0
                          ? f * MediaQuery.of(context).size.width - 24 * 3
                          : 0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              secondaryBackground: const ColoredBox(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              child: SizedBox(
                height: 72,
                child: ListTile(
                  title: Text(item),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SlidableWidget extends StatefulWidget {
  final Widget child;
  final Function onSlideStarted;
  final Function onSlideCompleted;

  SlidableWidget({
    required this.child,
    required this.onSlideStarted,
    required this.onSlideCompleted,
  });

  @override
  _SlidableWidgetState createState() => _SlidableWidgetState();
}

class _SlidableWidgetState extends State<SlidableWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isSlideStarted = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onSlideCompleted();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    _isSlideStarted = true;
    widget.onSlideStarted();
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isSlideStarted) return;

    _isSlideStarted = false;

    if (_animation.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final slideAmount = 100 * _animation.value;

          return Transform.translate(
            offset: Offset(slideAmount, 0),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
