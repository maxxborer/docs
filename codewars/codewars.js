var run = require("./run");

const args = "is2 Thi1s T4est 3a" || undefined;

run(function myDecision(funcArgs) {
  const result = [];
  funcArgs.split(' ').forEach(word => result[+/\d+/.exec(word) - 1] = word);
  return result.join(' ');
}, args);
