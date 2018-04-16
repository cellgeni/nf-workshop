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

## `work` directory
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

* `work` directory contains sub-directories where Nextflow executes its processes
* The names of the directories are randomly generated
* `splitLetters` was executed in the `66` sub-directory
* `convertToUpper` was executed in `7b` and `f5` sub-directories
* For each process Nextflow generates some system scripts and the outputs
* The original process command is in .command.sh
* `.command.run` is the script submitted to the cluster environment
* `.command.err`, `.command.log`, `.command.out` are the standard outputs
* `convertToUpper` depends on the output of `splitLetters`, a link has been created (no copying)

## Modify and resume
Let's modify the script block in the `convertToUpper` process (now will run `rev $x`):
```
process convertToUpper {
    input:
    file x from letters

    output:
    stdout result

    script:
    """
    rev $x
    """
}
```

and rerun Nextflow with the `-resume` flag:
```
> nextflow run hello-world.nf -resume
N E X T F L O W  ~  version 0.27.4
Launching `hello-world.nf` [mighty_goldstine] - revision: 0fa0fd8326
[warm up] executor > local
[66/5422cf] Cached process > splitLetters
[00/fc01e0] Submitted process > convertToUpper (1)
[b2/816523] Submitted process > convertToUpper (2)
olleH
!dlrow
```

Note that the first process `splitLetters` was cached and was not run at all!
## Pipeline parameters
Nextflow allows to define parameters inside the pipeline, e.g. in the [Hello, world!](hello-world.nf) pipeline there is a `str` parameter defined:
```
params.str = 'Hello world!'
```

We can use it in the command line to redefine the default value:
```
> nextflow run hello-world.nf --str 'Hola mundo'
N E X T F L O W  ~  version 0.27.4
Launching `hello-world.nf` [elated_hamilton] - revision: b0857ec305
[warm up] executor > local
[b3/924952] Submitted process > splitLetters
[d8/727942] Submitted process > convertToUpper (2)
[5a/3b7252] Submitted process > convertToUpper (1)
odnu
m aloH
```
