class DocumentPolicyAcknowledgeModel
{
  String? id;
  String? title;
  String? htmlText;

  DocumentPolicyAcknowledgeModel({
    required this.id,
    required this.title,
    this.htmlText
  });
}