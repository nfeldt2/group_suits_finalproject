import java.util.Map;

class PrimeLookup {
  Map<Integer, Integer> lookupTable;
  
  PrimeLookup() {
    this.lookupTable = new HashMap<>();
  }
  
  void addValue(int product, int rank) {
    lookupTable.put(product, rank);
  }
  
  Integer getValue(int prime) {
    return lookupTable.get(prime);
  }
}
