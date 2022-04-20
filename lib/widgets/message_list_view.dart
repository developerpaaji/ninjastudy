import 'package:flutter/material.dart';
import 'package:study/models/message.dart';
import 'package:study/widgets/typing_lottie.dart';

// Project imports:

class MessageAnimatedList extends StatefulWidget {
  final List<Message> messages;
  final Widget Function(BuildContext context, Message message, bool showAvatar)
      messageBuilder;
  final bool isTyping;
  final EdgeInsets? padding;
  const MessageAnimatedList({
    Key? key,
    required this.messages,
    required this.messageBuilder,
    this.isTyping = false,
    this.padding,
  }) : super(key: key);

  @override
  _MessageAnimatedListState createState() => _MessageAnimatedListState();
}

class _MessageAnimatedListState extends State<MessageAnimatedList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  late ScrollController _scrollController;
  late List<Message> _messages;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _messages = widget.messages;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _goToEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      padding: widget.padding,
      key: _key,
      initialItemCount: _messages.length,
      controller: _scrollController,
      itemBuilder: (context, index, animation) {
        Message message = _messages[index];
        final alignment = !(message.isBot ?? false)
            ? Alignment.centerRight
            : Alignment.centerLeft;
        bool showAvatar = true;
        if (index < _messages.length - 1) {
          if (_messages[index + 1].isBot == message.isBot) {
            showAvatar = false;
          }
        }
        Widget child = FadeTransition(
          opacity: Tween<double>(begin: 0.4, end: 1.0).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.1, end: 1.0).animate(animation),
            alignment: alignment,
            child: widget.messageBuilder(
              context,
              message,
              showAvatar,
            ),
          ),
        );

        if (index == _messages.length - 1 && widget.isTyping) {
          child = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              child,
              buildTypingIndicator(),
            ],
          );
        }
        return Container(
          margin: EdgeInsets.only(top: showAvatar ? 12 : 4),
          child: child,
        );
      },
    );
  }

  Widget buildTypingIndicator() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      alignment: Alignment.centerLeft,
      child: const TypingLottie(),
    );
  }

  @override
  void didUpdateWidget(covariant MessageAnimatedList oldWidget) {
    super.didUpdateWidget(oldWidget);
    var newMessages = widget.messages;
    var lastMessageRecorded =
        (_messages.isNotEmpty ? _messages.last.createdAt : null) ??
            DateTime(1971);
    for (var i = 0; i < _messages.length; i++) {
      final message = _messages[i];
      int index = newMessages.indexWhere((element) => element.id == message.id);
      if (index >= 0) {
        _messages[i] = newMessages[index];
      }
    }
    setState(() {});

    var messages = Set<Message>.from(newMessages)
        .difference(Set<Message>.from(_messages))
        .toList();
    final greatherThan = messages
        .where((element) =>
            (element.createdAt?.compareTo(lastMessageRecorded) ?? 0) > 0)
        .toList();
    final lessThan = messages
        .where((element) =>
            (element.createdAt?.compareTo(lastMessageRecorded) ?? 0) <= 0)
        .toList();
    greatherThan.sort((a, b) =>
        (a.createdAt?.compareTo((b.createdAt ?? DateTime(1971))) ?? 0));
    lessThan.sort((b, a) =>
        (a.createdAt?.compareTo((b.createdAt ?? DateTime(1971))) ?? 0));

    for (var element in lessThan) {
      _messages.insert(0, element);
      _key.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 300));
    }
    for (var element in greatherThan) {
      _messages.add(element);
      _key.currentState?.insertItem(_messages.length - 1,
          duration: const Duration(milliseconds: 300));
    }
    _goToEnd();
  }

  void _goToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }
}
