void renderBody(ArrayList<Tail> body) {
  for(Tail thisTail : body) {
    renderTail(thisTail);
  }
}

void renderTail(Tail thisTail) {
  thisTail.render();
}

void renderHead(Head thisHead) {
  thisHead.render();
}

boolean renderFood(Food thisFood) {
  if(thisFood.ate) return false; // Cancel the render if food is already ate
  thisFood.render();
  return true;
}
