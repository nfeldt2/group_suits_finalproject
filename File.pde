class File {
  
  String name;
  
  File () {
    name = "saver.txt";
  }
  
  int load () {
     String[] line = loadStrings(name);
     int bank = int(line[0]);
     println(bank);
     return bank;
  }

  void save (int num) {
    String[] s = {num + ""};
    saveStrings(name, s);
  }
}
