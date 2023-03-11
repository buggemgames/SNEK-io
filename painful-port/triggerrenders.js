function renderBody(body) {
  for(let thisTail of body) {
    renderTail(thisTail);
  }
}

function renderTail(thisTail) {
  thisTail.render();
}

function renderHead(thisHead) {
  thisHead.render();
}

function renderFood(thisFood) {
  if(thisFood.ate) return false; // Cancel the render if food is already ate
  thisFood.render();
  return true;
}
