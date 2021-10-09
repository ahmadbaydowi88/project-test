void main() {
  var array = [
    "Saat meng*ecat tembok, Agung dib_antu oleh Raihan.",
    "Berapa u(mur minimal[ untuk !mengurus ktp?",
    "Masing-masing anak mendap(atkan uang jajan ya=ng be&rbeda."
  ];
  final validCharacters = RegExp(r'^[a-zA-Z0-9\-@,\.;?]+$');
  var newArray = [];

  array.asMap().forEach((index, arr) {
    newArray.clear();
    var split = arr.split(" ");

    split.forEach((element) {
      var check = validCharacters.hasMatch(element);
      if (check) {
        newArray.add(element);
      }
    });

    print("Soal " + (index + 1).toString() + ": " + newArray.length.toString());
  });
}
