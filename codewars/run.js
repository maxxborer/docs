function bench(func, args, numberIters) {
  var start = new Date();
  for (var i = 0; i < numberIters; i++) func(args);
  console.log(" " + numberIters + " bench: " + (new Date() - start) + "ms");
}

function runFunc(func, args, start) {
  const result = func(args);
  console.log(
    " type: ", typeof result, "\n",
    { result }, "\n",
    "JSON: ", JSON.stringify(result, null, "\t")
  );
  console.log("\n COMPLETED IN: " + (new Date() - start) + "ms\n");
}

function run(func, args, runBench = true) {
  const start = new Date();
  console.log(
    " " +
      ("0" + start.getHours()).slice(-2) +
      ":" +
      ("0" + start.getMinutes()).slice(-2) +
      ":" +
      ("0" + start.getSeconds()).slice(-2) +
      "\n"
  );

  runFunc(func, args, start);

  if (runBench) {
    bench(func, args, 100);
    bench(func, args, 1000);
    bench(func, args, 10000);
    bench(func, args, 100000);
    bench(func, args, 1000000);
    // bench(func, args, 10000000);
  }

  console.log("\n END: " + (new Date() - start) + "ms");
  console.log("--------------------------------------");
}

module.exports = run;
