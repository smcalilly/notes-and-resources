# Using Make for ETL
These notes are from [the DataMade document "Making Data, the DataMade Way"](https://github.com/datamade/data-making-guidelines)

DataMade uses Make for ETL.

### Basic Principles
1. **Never destroy data**. Treat source data as immuatble and show your work when you modify it.
2. Be able to deterministically produce the final data with a single command.
3. Write as little custom code as possible.
4. Use standard tools whenever possible.
5. Keep source data under version control.

## Make & Makefile Overview
GNU's Make is a build automation tool. It keeps track of dependencies and executes shell commands. It's often used to compile software. It's got some features that make it useful for processing data, too.

Make runs in the command line and Makefiles are written primarily in bash.

### 1. why use make/makefiles?
Make generates files called **targets**. Each target can depend upon the existence of other files **dependencies**. Targets, dependencies, and the **recipes** for how to build them are defined in a file called a Makefile.

Make looks as the files in your dependency graph and figures out the individual steps required to build the output that you want. If you're trying to make a target and already have some dependencies, Make will skip the steps required to produce those dependencies. If you're missing the dependencies, it will figure out the fastest way to produce them. This means that you can change a rule or a dependency and rebuild your output without having to re-run every single step.

Make is a nifty data processing tool because:
- it allows you to produce your final data with a single command
- writing a makefile forces you to make your data processing steps explicit
- it's smart about only building what's necessary, because it keeps track of dependencies
- it's efficient and gives you parallel processing
- make comes built-in to UNIX systems 

[This is a very good blog post that argues why to use Make for data processing.](https://bost.ocks.org/mike/make/) It also has some nice examples.

### 2. Makefile 101
#### Rules
A **rule** is the basic building block of a Makefile. It's a small block of cod ethat executes one step of your data-making process. 

Each rule consists of:
1. a target
2. the target's dependencies
3. the target's recipes (the commands for creating the target)

It looks like this:
```bash
<target>: <dependencies>
    <recipe>
```

**important!**: recipes absolutely must be indented with a tab (and not spaces). this can be a common source of strange errors.


#### target
The target is what you want the rule to generate. A target doesn't have to be a literal filename. It can be a **phony target** or a **variable** (two special kinds of targets). These target types are useful for writing Makefiles.

The most important concept to understand: a target is the identifying label for a rule that allows the user to reference it.

#### dependencies
A rule's dependencies are everything that needs to exist in order to make the target. Like targets, Make expects dependencies to be files, but they can also be phony targets or variables. Dependencies are optional. If you have no dependencies, Make will run whatever code is in the recipe, whethere or not you have everything it needs to run. Dependencies are useful for making sure that all of your files are ready to generate your target.

#### recipe
A recipes lists the commands that Make eneds to run to generate the target. Anything you can run on the command line is fair game for recipes. You're free to use command line utilities, edit the filesystem, and run scripts in your recipe. If your recipe requires dependencies that aren't built-in to bash or included in the repo, then let the users know these requirement's in your repo's readme.

#### Makefile
A Makefile is mostly a collection of rules for generating targets, as well as the dependencies for those targets. It's like any program you'd write: it defines functions for running code to modify files.

#### thinking backwards
for make, you need to think about the output you produce. basically, you're returning data. this is where you start. (it seems pretty functional, like returning a pure function) (Q: does the file  need to be "arranged" backwards or is this just a concept to help understand how to think about creating a Makefile)

#### running make
oh i see. make will look at your intended output and then go from there, seeing which dependencies it needs to update. it's basically recursively going through your makefile and generating a dependency tree that starts with your output and goes all the way to the most basic missing dependency.

### 3. Makefile 201 - fancy Make built-ins

#### phony targets
by default, Make assumes that targets are files (and they usually are). however, sometimes it's useful to define rules that do not produce a single file, but instead perform some set of commands. for example, you might want to make all of the targets in a makefile at once, or you might want to remove everything you've create from your directory. in both cases, make needs to do a bunch of things to a bunch of files, rather than run commands to produce one single file. this is when you'd use a **phony target**.

phony targets aren't defined by one specific files, but instead act more like function names, encapsulating a set of useful commands.

to define a phony target, you must tell make that they are not associated with files, like so:
```bash
.PHONY all clean
```

Make understands that the `all` target and the `clean` target are phony targets, and won't make files out of them.

- `all` makes all targets defined in the Makefile at once
- `clean` removes all generated targets from the directory

it often looks like this:
```Makefile
# make all targets
all: $(GENERATED_FILES)

# remove all generated targets
clean:
    rm -Rf finished/*
```

here is good psuedocode example to understand how you can use variables:
```Makefile
final_table: clean_schools.csv clean_scores.csv
    join clean_schools.csv clean_scores.csv > final_table
```

you can use the variables for the dependencies:
```Makefile
final_table: clean_schools.csv clean_scores.csv
    join $^ > $@
```

- [see here for some cool pattern rule wizardry](https://github.com/datamade/data-making-guidelines/blob/master/make.md#pattern-rules-implicit-rules)
- [functions for filenames](https://github.com/datamade/data-making-guidelines/blob/master/make.md#functions-for-filenames)

#### automatic variables
- `$@` the filename of the target
- `$^` the filenames of all dependencies
- `$?` the filesnames of all dependencies that are newer than the target
- `$<` the filenames of the first dependency

### style
[there is a style guide here](https://github.com/datamade/data-making-guidelines/blob/master/styleguide.md)

### tools
[standard toolkit](https://github.com/datamade/data-making-guidelines/blob/master/styleguide.md#4-standard-toolkit)

### resource
- [make docs](https://www.gnu.org/software/make/manual/make.html)
- [annotated example](https://datamade.github.io/data-making-guidelines/)
- [makefile style guide](https://clarkgrubb.com/makefile-style-guide#data-workflows)
- [why use make + an example for working with geojson](https://bost.ocks.org/mike/make/)
