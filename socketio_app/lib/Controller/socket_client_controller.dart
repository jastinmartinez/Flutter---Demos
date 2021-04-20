import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socketio_app/Model/chat_message.dart';

import 'package:socketio_app/helper/notification.dart';

enum SocketStatus { Connecting, Connected, Joined, Disconnected, Error }

class SocketClientController extends GetxController {
  final _nickUserName = "".obs;
  final _numberOfUser = 0.obs;
  final _onInputText = "".obs;
  final _sockerStatus = SocketStatus.Connecting.obs;
  final _typingUser = Map<String, String>().obs;

  final _chatMessages = List<ChatMessage>().obs;

  RxInt get numberOfUser => _numberOfUser;
  RxString get onInputText => _onInputText;
  RxString get nickName => _nickUserName;

  Rx<SocketStatus> get socketStatus => _sockerStatus;
  RxList<ChatMessage> get chatMessage => _chatMessages;

  String get typingUser {
    if (_typingUser.isNotEmpty) return _typingUser['username'];
    return null;
  }

  Socket _socket;
  Worker _typingWorker;

  @override
  void onInit() {
    init();
    connetToChat();
    super.onInit();
  }

  void init() {
    debounce(
      _onInputText,
      (_) {
        _socket?.emit('stop typing');
        _typingWorker = null;
      },
      time: Duration(milliseconds: 500),
    );
  }

  void connetToChat() {
    _socket = io(
      'https://socketio-chat-h9jt.herokuapp.com/',
      <String, dynamic>{
        'transports': ['websocket'],
      },
    );

    _socket.on(
      'connect',
      (_) {
        socketStatus.value = SocketStatus.Connected;
      },
    );

    _socket.on(
      'connect_error',
      (_) {
        socketStatus.value = SocketStatus.Error;
      },
    );

    _socket.on(
      'disconnect',
      (_) {
        socketStatus.value = SocketStatus.Disconnected;
      },
    );

    _socket.on(
      'login',
      (data) {
        _numberOfUser.value = data['numUsers'];
        socketStatus.value = SocketStatus.Joined;
      },
    );

    _socket.on(
      'user joined',
      (data) {
        _numberOfUser.value = data['numUsers'];
      },
    );

    _socket.on(
      'typing',
      (data) {
        _typingUser.putIfAbsent(
          'username',
          () => data['username'],
        );
      },
    );

    _socket.on(
      'stop typing',
      (_) {
        _typingUser.remove('username');
      },
    );
    _socket.on(
      'user left',
      (data) {
        Notification.showUserLeft('${data['username']} left');
        _numberOfUser.value = data['numUsers'];
      },
    );

    _socket.on(
      'new message',
      (data) {
        _chatMessages.add(
          ChatMessage(
            useName: data['username'],
            userMessage: data['message'],
            userSender: false,
          ),
        );
      },
    );
  }

  void joinChat(String nickName) {
    _nickUserName.value = nickName;
    _socket?.emit('add user', nickName);
  }

  void disconnectFromChat() {
    this._socket?.disconnect();
    _socket = null;
  }

  void onInputChange(String text) {
    if (_typingWorker == null) {
      _typingWorker = once(
        _onInputText,
        (_) {
          _socket?.emit('typing');
        },
      );
    }
    _onInputText.value = text;
  }

  bool sendMessage() {
    if (_onInputText.trim().length > 0) {
      _socket.emit('new message', _onInputText.value);
      _chatMessages.add(
        ChatMessage(
          useName: _nickUserName.value,
          userMessage: _onInputText.value,
          userSender: true,
        ),
      );
      _onInputText.value = "";
      return true;
    }
    return false;
  }
}
