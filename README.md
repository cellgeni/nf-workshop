# Nextflow workshop
Nextflow workshop at the Sanger Institute

## Clone the workshop repo and install Nextflow
```
git clone git@github.com:cellgeni/nf-workshop.git
cd nf-workshop
curl -s https://get.nextflow.io | bash
ls
```

## Hello world! pipeline
* The [Hello world! pipeline](hello-world.nf) defines two processes
* `splitLetters` splits a string in file chunks containing 6 characters
* `convertToUpper` receives these files and transforms their contents to uppercase letters
* The resulting strings are emitted on the result channel and the final output is printed by the subscribe operator

## Run the pipeline
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

## work directory
```
> tree -a work
work
├── 66
│   └── 5422cf0adc07c4662eaaa04b5c1700
│       ├── .command.begin
│       ├── .command.err
│       ├── .command.log
│       ├── .command.out
│       ├── .command.run
│       ├── .command.sh
│       ├── .exitcode
│       ├── chunk_aa
│       └── chunk_ab
├── 7b
│   └── 86f99a5e06fe183daee815b2cf09c7
│       ├── .command.begin
│       ├── .command.err
│       ├── .command.log
│       ├── .command.out
│       ├── .command.run
│       ├── .command.sh
│       ├── .exitcode
│       └── chunk_aa -> /Users/vk6/nf-workshop/work/66/5422cf0adc07c4662eaaa04b5c1700/chunk_aa
└── f5
    └── 56dcd57618fe720c4ed4602055f68a
        ├── .command.begin
        ├── .command.err
        ├── .command.log
        ├── .command.out
        ├── .command.run
        ├── .command.sh
        ├── .exitcode
        └── chunk_ab -> /Users/vk6/nf-workshop/work/66/5422cf0adc07c4662eaaa04b5c1700/chunk_ab

6 directories, 25 files
```

* `work` directory contains sub-directories where Nextflow executes it’s processes
* The names of the directories are randomly generated
* splitLetters was executed in the `66` sub-directory
* convertToUpper was executed in `7b` and `f5` sub-directories