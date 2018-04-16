# nf-workshop
Nextflow workshop at the Sanger Institute

# Clone the workshop repo and install Nextflow
```
git clone git@github.com:cellgeni/nf-workshop.git
cd nf-workshop
curl -s https://get.nextflow.io | bash
ls
```

# Hello, world! pipeline
* The [Hello, world! pipeline](hello-world.nf) defines two processes
* `splitLetters` splits a string in file chunks containing 6 characters
* `convertToUpper` receives these files and transforms their contents to uppercase letters
* The resulting strings are emitted on the result channel and the final output is printed by the subscribe operator

# Run the pipeline
```
> nextflow run hello-world.nf
N E X T F L O W  ~  version 0.27.4
Launching `hello-world.nf` [exotic_bartik] - revision: 361b274147
[warm up] executor > local
[e7/7d678f] Submitted process > splitLetters
[5e/fe9bf6] Submitted process > convertToUpper (2)
[bb/75ef46] Submitted process > convertToUpper (1)
WORLD!
HELLO
```

* The first process is executed once, and the second twice
* The result string is printed
* convertToUpper is executed in parallel, so it is possible that you will get the final result printed out in a different order:
```
HELLO
WORLD!
```
