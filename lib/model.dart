class Model{
  final String image,url,label,source;

  var ingredientLines;

  Model({
    required this.image,
    required this.url,
    required this.label,
    required this.ingredientLines,
    required this.source
  });

  factory Model.fromjson(Map<dynamic, dynamic> json){
    return Model(
      url: json['recipe']['url'] ?? '',
      image: json['recipe']['image'] ?? '',
      label: json['recipe']['label'] ?? '',
        source: json['recipe']['source'] ?? '',
        ingredientLines: json['recipe']['ingredientLines'] ?? '',
    );}
}