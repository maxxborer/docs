var run = require("./run");

const args = 67 || undefined;

run(function myDecision(funcArgs) {
  return String(funcArgs); // решение задачи
}, args);
