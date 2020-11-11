
# The puzzle of the Pyramids

Here we'll introduce some concepts from the programming language Python, using
small examples. You can try out any example given here for yourself using
the Trinket code cells. These cells provide small runnable environments where
your can write and run Python code. The code is written (and can be modified!)
in the frame on the left, while your output will be  displayed in the frame on
the right.

At the end of this introduction we'll describe an assignment, which you should
try and solve using all of the introduced concepts below.

## Hello World!

The classic first program to write in any language is Hello World, which in
Python would look like:

    print("Hello World!")

This is a pretty simple program, but let's take a look at the elements it
contains:

### Strings

A string is a piece of text surrounded by quotes. Examples of strings are

    "It's a good day to code"

    "Python 3.8"

    "Lorem ipsum dolor sit amet, consectetur ..."

### Printing

Python comes with many features already built-in, most of which come as
*functions*. One of the most commonly used built-in functions is `print()`,
which prints a string (i.e. a piece of text) to the screen.

You can provide whatever string you like between the parentheses as the
function *argument* and that string will be printed.

<iframe src="https://trinket.io/embed/python3/4a977e33ed?showInstructions=true" width="100%" height="150" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

The output should appear in the frame on the right. Try editing the string that
is printed and running your own version of the program.

## Variables

Next, lets introduce another essential bit of Python; *variables*.

Variables are named entities that can be used to store things in your program.
Variables also always have a *type*. We've already seen one type of variable,
namely a string. Expanding the Hello World program slightly, we might write:

    greeting = "Hello World!"
    print(greeting)

Where we store the string "Hello World!" in the variable `greeting` and then
print that variable.

### Integers

A different type of variable that is very useful is an *integer*. Integers are
used to represent whole numbers, such as 3, 5, 24 or 917. They can be printed
in the exact same way as strings:

    number = 5
    print(number)

### Doing calculations

You can also perform calculations using integers and store the result in a new
variable, like so

    first_number = 5
    second_number = first_number + 3
    print(second_number)

The code will always be executed from the top line to bottom, in order. So, the
order of the commands matters:

<iframe src="https://trinket.io/embed/python3/74f9dd4211" width="100%" height="250" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

Make sure to try these examples for yourself! Try some other variations too. If
you understand the output produced, move on to the next step.

## User input

You can also collect user input using the `input()` function. The argument of
the input function is the question you want to ask the user:

    name = input("What is your name? ")

The result is then stored as a string. If you want to use an integer, you can
convert the string to an integer using the `int()` function, like so

    age_string = input("What is your age? ")
    age = int(age_string)

### Printing on a single line

Prints are always followed by an *enter*, i.e. a new line. Using the example
inputs from above, if you would print

    print(name)
    print(age)

then each would appear on a new line. If you instead want to print them on the
same line, but with space between them, you could use this modified version of
the print, which used the optional `end=' '` argument:

<iframe src="https://trinket.io/embed/python3/b3e7ef2202" width="100%" height="250" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

### A small exercise: Greeting the user

Write a program that ask the user for their name, and prints a greeting. If the
user enters the name John, your program should print "Hello John !", like
so:

    What is your name? John
    Hello John !

Your program should of course work for any name entered

    What is your name? Sarah
    Hello Sarah !

Write your solution in code cell below:

<iframe src="https://trinket.io/embed/python3/cc0960f302" width="100%" height="200" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

### Another small exercise: Water

Assume that taking a shower for 1 minute consumes about 12 (0.5 liter) bottles
of water. Write a program that reports a user’s water usage back to them, by
calculating the how many bottles of drinking water are consumed by the number
of minutes they shower. Example:

    How many minutes do you shower? 1
    12

    How many minutes do you shower? 10
    120

Tip: In this exercise you need to make sure that you use the function `int()`
to convert the user input from a string into an integer. If you skip this step,
you might get very unexpected results.

<iframe src="https://trinket.io/embed/python3/22b3b013df" width="100%" height="200" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

## For Loops

One of the most useful constructs in programming is a loop. A loop can be used
to repeat certain instructions. The most basic version, repeating a print 5
times, would be written as

<iframe src="https://trinket.io/embed/python3/a29d2bc74b" width="100%" height="200" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

Which should print the string "Hello!" 5 times

### Indentation

An important piece of Python syntax is the indentation. After the `:` the
contents of the loop starts, which are all the elements that should be
repeated. Every indented line, i.e. every line preceded by *tab* character and
therefore starting shifted slightly to the right, is considered to be *inside
the loop* and is repeated for the duration of the loop.

<iframe src="https://trinket.io/embed/python3/9c1f2567d9" width="100%" height="200" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

### Range

The `range()` function in the loop indicates how often the loop should repeat.
The variable after the *keyword* `for` (called `i` in these examples) changes
every step of the loop, starting at 0 and increasing with 1 for every step, up
to the number specified steps.

<iframe src="https://trinket.io/embed/python3/d5eb78cf2a" width="100%" height="200" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

The number of specified steps in the `range()` function here is 7, so the
variable `i` will start at 0 and run up to and including 6. Note that the total
number of steps is still 7, due to starting the count a 0 (a common convention
in computer science).

### Nested Loop

The indented section of a for-loop indicates what parts of the code you want to
repeat. The code inside the loop could be any Python code. You could even put
*another* loop inside the first loop! This inner loop will then executed
completely from start to finish for every single step of the outer loop. This
is easiest to understand with an example:

<iframe src="https://trinket.io/embed/python3/7fa5a90f9f" width="100%" height="400" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

Any lines of code indented with *2* tabs are part of the inner loop, while
code indented with 1 tab is only part of the outer loop.

*Check your own understandig:* How many times does this loop print "One inner
loop step completed"? Why is that?

## Building the Pyramid

For this next part, you'll have to use all of the concepts introduced above to
write your own program. The program should write a pyramid of the correct
height to the screen, based on what height the user entered. Some examples:

    What height would you like the pyramid to be? 5
            # #
          # # #
        # # # #
      # # # # #
    # # # # # #

    What height would you like the pyramid to be? 2
      # #
    # # #

    What height would you like the pyramid to be? 7
                # #
              # # #
            # # # #
          # # # # #
        # # # # # #
      # # # # # # #
    # # # # # # # #

### Write your own solution

Write Python code in the cell below to exactly reproduce the input/output
examples above. You should *only* use Python constructs that have been
introduced in this text to solve this assignment. Your code should work for any
positive integer given as the height of the pyramid, but your code may produce
errors if other inputs are given by the user.

<iframe src="https://trinket.io/embed/python3/9ef13c7b92" width="100%" height="400" frameborder="0" marginwidth="0" marginheight="0" allowfullscreen></iframe>

The introduction given could already be enough information for you to start
experimenting and some writing code above. If you're not sure where to start
yet, check out some of the hints in the next section.

When you're done, don't forget to save your solution on in a text file called
`pyramid`. We'd like you to submit your final result as part of this
introduction, however your result won't be used as a selection criterium.

### Building blocks for the pyramid

The text above should have given you an idea of the building blocks and what to
build, but the main challenge with programming is figuring out how to combine
all the elements together into a program that solves the whole problem.

Generally, a very effective strategy is trying to write smaller pieces of code,
which might be useful a step towards solving the whole problem and test each of
these separately. You can then incrementally expand the complexity of your
program and work towards solving the problem as a whole. Here we'll outline
some of the steps you might use

#### Step 1. Get input and put down some blocks

Write a program to ask the user to input a number and print that number of
hashes, e.g.

    What height would you like the pyramid to be? 4
    # # # #

    What height would you like the pyramid to be? 7
    # # # # # # #

#### Step 2. Build a cube

Modify your program from step 1 to repeat the printed output height number of
times. The result should be a square of *height x height*, e.g.

    What height would you like the pyramid to be? 3
    # # #
    # # #
    # # #

    What height would you like the pyramid to be? 5
    # # # # #
    # # # # #
    # # # # #
    # # # # #
    # # # # #

#### Step 3. Carve out a pyramid

Modify your program from step 2 to only display the correct number of blocks on
every row. Don't worry about the exact placement yet, only make sure the
correct number of blocks is printed, e.g.

    What height would you like the pyramid to be? 2
    # #
    # # #

    What height would you like the pyramid to be? 6
    # #
    # # #
    # # # #
    # # # # #
    # # # # # #
    # # # # # # #

#### Step 4. Add some scaffolding to align the pyramid

Modify your program from step 3 to produce an output where the hashes are
aligned as in the actual output, described at the start of this section.
Remember that prints on the same line are places in order, from left to right.
So, if you want to shift something to right, you might need add some characters
*before* those other characters, in order to shift them further right. Use the
character `.` fix the alignment of the hashes, e.g.

    What height would you like the pyramid to be? 5
    . . . . # #
    . . . # # #
    . . # # # #
    . # # # # #
    # # # # # #

    What height would you like the pyramid to be? 3
    . . # #
    . # # #
    # # # #

#### Step 5. Remove the scaffolds and admire your work

Modify your program from step 4 to produce exactly the same output as described
at the start of this section. All that needs to be done is to replace the
scaffolding character with something that will not be directly visible in the
output, e.g.

    What height would you like the pyramid to be? 7
                # #
              # # #
            # # # #
          # # # # #
        # # # # # #
      # # # # # # #
    # # # # # # # #


