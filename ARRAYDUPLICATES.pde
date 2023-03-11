ArrayList removeDuplicates(ArrayList toCopy) {
  ArrayList finalResult = new ArrayList();
  for(int i = 0; i < toCopy.size(); i++) {
    if(!(finalResult.contains(toCopy.get(i)))) {
      finalResult.add(toCopy.get(i));
    }
  }
  return finalResult;
}
