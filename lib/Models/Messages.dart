class Messages{
  String senderid;
  String receiverid;
  String receivedAt;
  String message;
  String messageType;
  String messageRecivierType;
  bool read;

  Messages({
    this.senderid,
    this.receiverid,
    this.receivedAt,
    this.message,
    this.messageType,
    this.messageRecivierType,
    this.read
});
}