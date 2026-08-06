---
layout: welkom-tutorial
title: Python setup with uv
tutorial_questions:
  os:
    question: "What operating system are you using?"
    choices:
      mac: "macOS"
      linux: "Linux"
      windows: "Windows"
  setup:
    question: "What did your course provide?"
    description: "If you don't know what we're asking, please read the previous section."
    choices:
      nothing: "Nothing (no config file)"
      requirements: "A requirements.txt file"
      pyproject: "A pyproject.toml file"
---

* Auto-generated table of contents for this page
{:toc}

# Python setup manual with `uv`

This guide shows how to:

- install `uv` and a recent Python version
- create a programming folder and subfolders for your courses
- manage Python packages required for each course
- how to run your Python programs

There are other ways to manage Python! But in this tutorial, we try to provide a consistent experience that is useful in a university setting.

## Some background on files and folders

If you are new to programming, it is important to understand how files and folders work. All your documents are stored on your computer as a file. To help you organize a large number of files, you can use folders.

- A **file** is a document or piece of data, such as a Python program (the name will end in `.py`), but it could also literally be a data file (for example, ending in `.csv`) or a Word document (ending in `.docx`).

- A **folder** (also called a directory) is a container, and it can hold files. But a directory can also contain other directories. This means that you can organize your files in a hierarchical structure.

For example:

- `programming/` → a main folder
- `my-course/` → a folder inside `programming`
- `hello.py` → a file inside `my-course`

Adding two other files, the structure may look like this:

~~~text
programming/
└── my-course/
    ├── hello.py
    └── week1.py
    └── zac-data-2026.csv
~~~

The files that you will be mostly concerned with are **Python files**. You will often start with an empty (blank) file, write Python code, save the file and then **Run** it. But more on that later.

### Paths

A **path** is a complete description of where some file can be found, including the names of all the directories it is contained in. Instead of a file, a path can also point to a directory.

For example, you probably have been saving files in the `Documents` folder on your computer. Here are examples of the full path to a folder inside your documents directory:

- `/Users/isaiah/Documents/UvA/intro` (macOS/Linux)
- `C:\Users\isaiah\Documents\UvA\intro` (Windows)
- `C:\Users\isaiah\OneDrive\Documents\UvA\intro` (Windows with OneDrive)

#### Home directory

The paths above start with `/Users/isaiah/` and `C:\Users\isaiah`. These are the paths pointing to your "home directory". Your home directory is your personal space on the computer where your files live, separate from other people that might use the same computer.

#### Shortcuts

Because many of your files are in your home directory, there is a shortcut! Instead of the full path, you can use `~` (macOS/Linux) or `$HOME` (Windows PowerShell).

This means that you can use slightly shorter paths to the same location:

- `~/Documents/UvA/intro` (macOS/Linux)
- `$HOME\Documents\UvA\intro` (Windows)
- `$env:OneDrive\Documents\UvA\intro` (Windows with OneDrive)

> That last one can be used when you are on Windows and use OneDrive. In that case the directory `$HOME\Documents` may be empty, and instead your real `Documents` directory is inside the `OneDrive` directory. This is because OneDrive can only manage file inside the `OneDrive` directory. It is also possible that you have files in both places. That's something you should fix.

## Working with your computer from a shell

When you normally use your computer, you click on icons, open folders, and drag files. This is called a **graphical user interface (GUI)**.

A **shell** is a different way to interact with your computer. Instead of clicking, you type commands.

You access the shell through a program called a **terminal**.

- On macOS: Terminal
- On Linux: Terminal
- On Windows: PowerShell or Windows Terminal

### Opening the terminal

#### macOS [mac]

1. Press `Cmd + Space` to open Spotlight search
2. Type `Terminal`
3. Press Enter

A window opens with text like this:

~~~text
Last login: ...
username@macbook ~ %
~~~

The `%` is the **prompt**. The prompt is the place where you type commands. It means the terminal is ready to take a command.

Also, do you see that tiny `~` before the percent sign? This is the directory that the shell is attached to. In this case it's your home directory, like you learned earlier.

#### Windows (PowerShell) [windows]

1. Press the Windows key
2. Type `PowerShell` or `Windows Terminal`
3. Press Enter

A window opens with text like this:

~~~text
PS C:\Users\YourName>
~~~

The `>` is the **prompt**. The prompt is the place where you type commands. It means the terminal is ready to take a command.

The shell also displays the path of the directory that it is attached to; in this case `C:\Users\YourName`.

### First steps in the terminal

You can try a few simple commands to look inside directories and see what files and directories are there:

#### macOS/Linux [mac/linux]

Show a list of files in the current folder:

~~~bash
ls
~~~

Move into your Documents folder:

~~~bash
cd ~/Documents
~~~

"Moving into" here means attaching the shell to another directory. If you then issue `ls` again, you will get a listing of the files in *that* directory.

#### Windows PowerShell [windows]

Show a list of files in the current folder:

~~~powershell
dir
~~~

Move into your Documents folder:

~~~powershell
cd $HOME\Documents
~~~

"Moving into" here means attaching the shell to another directory. If you then issue `dir` again, you will get a listing of the files in *that* directory.

### Moving between folders

This is such an important concept that we elaborate on it once more. You have previously seen that you can move into a different directory by typing the command `cd` in the shell (change directory).

You will be doing this very often, especially when you start the terminal again. The shell will always load attached to your home directory. That is *not* where you will be saving your files! So you need to move into the right folder before doing anything.

For example, you might want to run a Python program called `mario.py` which is in the `Programming/pyprog` directory in your `Nextcloud` directory.

#### macOS and Linux [mac/linux]

~~~bash
cd ~/Nextcloud/Programming/pyprog
uv run mario.py
~~~

#### Windows [windows]

~~~powershell
cd $HOME\Nextcloud\Programming\pyprog
uv run mario.py
~~~

The second command, `uv run`, would not work at all if you did not `cd` into the `pyprog` directory first.

### How the shell relates to normal computer use

The shell lets you do the same things as clicking, but using text commands.

For example:

- open a folder → `cd foldername`
- list files → `ls` (macOS/Linux) or `dir` (Windows)
- run a program → type its name

This guide uses the shell because programming tools like `uv` are controlled with commands.


#### Why this matters

Programmers generally work in the shell a lot, because it helps them work better:

- Commands are precise and repeatable
- You can follow instructions exactly as written
- Many programming tools are designed for shell use

Working in the shell do not replace your normal way of using the computer; you add the shell as a second way of working.




## Installing uv and Python

`uv` is a Python package and environment manager. It replaces several older tools you may see in other guides, such as:

- `pip` (for installing packages)
- `venv` (for creating virtual environments)
- separate Python installers

Instead of learning multiple tools, you use **one tool (uv) for everything**. This has advantages, but also disadvantages. For now it keeps learning simple, and you can expand your knowledge later.

### Install uv now

Open a terminal and install it.

#### macOS and Linux [mac/linux]

Run the following command from your terminal:

~~~bash
curl -LsSf https://astral.sh/uv/install.sh | sh
~~~

After installation, close and reopen your terminal.

Check that it works:

~~~bash
uv --version
~~~

There could be errors! In that case ask your teacher.

#### Windows [windows]

In PowerShell, run:

~~~powershell
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
~~~

Then reopen PowerShell and check:

~~~powershell
uv --version
~~~

### Install a Python version with `uv`

The first step when using `uv` is to install Python itself. You will need a recent version of Python, and `uv` makes it very easy to get that.

For example, to install Python 3.14:

~~~bash
uv python install 3.14
~~~

You can check which Python versions are available on your system with:

~~~bash
uv python list
~~~

Sometimes this will list a few older versions, as well. That is fine: in a later step, you will configure to use Python 3.14 during your course work.



## Creating folders for all your courses

You will now need to decide where your course files are going to be saved on your computer. Probably you have already created a place for university work, for example in your `Documents` directory. You may or may not have organized it, for example by making a folder for each separate course.

Your first task is to create a directory where all your **programming-related course** files are going to be. This is not necessarily the same directory as where other university work is stored. You will have multiple programming courses, and maybe a few projects, so it's good to make a dedicated directory for that.

> In the next section, we will suggest the best options. It's fine if you make a different decision. However, do **not** save your work in Downloads, on the Desktop, or inside other "easy to access" folders. Such directories are not backed up, which will be very sad when your computer crashes and you lose all of it.


### Installing Nextcloud

Ideally, your work is automatically backed up. Unfortunately, saving Python projects in iCloud or OneDrive is a bit of a problem. Hence, you will install Nextcloud, as provided by the University of Amsterdam. It will take care of automatic backup.

1. Install <a href="https://nextcloud.com/install/#desktop-files" target="_blank" rel="noopener">Nextcloud</a>, a tiny program that synchronizes files from your computer to the cloud (only files in a specific directory).

2. When asked, press **Login** and enter the SurfDrive address:

        https://surfdrive.surf.nl

3. Login using your UvA credentials.

4. You will now have a folder called `Nextcloud`.

5. Go to the Nextcloud settings using the **...** button:

    ![](dotdotdot.png)

6. Choose **Edit ignored files**:

    ![](dotmenu.png)

7. Add `.venv` (don't forget the dot!) and check the **Allow deletion** marker:

    ![](ignorevenv.png)


### Good locations for your work

Choosing the right location matters because you do not want to lose your work and you want it to be easy to find.

> **Do not save your Python work on OneDrive or iCloud**. You should have installed Nextcloud in the previous step.

#### macOS [mac/linux]

Put a `Programming` folder inside your `Nextcloud` folder:

- example: `~/Nextcloud/Programming`


#### Windows [windows]

Put a `Programming` folder inside your `Nextcloud` folder:

- example: `C:\Users\<you>\Nextcloud\Programming`

### Creating a subfolder for one course or project

Let's say that you are using the following path as your programming folder:

- macOS/Linux: `~/Nextcloud/Programming`
- Windows: `$HOME\Nextcloud\Programming`

Now it's time to create a course-specific subfolder.

#### macOS and Linux [mac/linux]

`mkdir` means “make directory” (create a folder).

~~~bash
mkdir -p ~/Nextcloud/Programming/my-course
cd ~/Nextcloud/Programming/my-course
~~~

#### Windows PowerShell [windows]

`mkdir` means “make directory” (create a folder).

~~~powershell
mkdir $HOME\Nextcloud\Programming\my-course
cd $HOME\Nextcloud\Programming\my-course
~~~

Replace `my-course` with the actual name of your course.

Use simple names without spaces (for example: `python101`, not `python 101`). If you do use spaces, working with that directory becomes very annoying in the shell.

Good examples:

- `python101`
- `intro-programming`
- `datascience-course`


## Create a virtual environment for the course

Now that you have a directory for the course, you should make a virtual environment inside it. A **virtual environment** contains a Python setup just for this course or project.

Why this matters:

- it keeps packages for this course separate from other courses
- it avoids conflicts between different projects
- it makes it easier to reproduce the same setup later

We distinguish a few options:

1. Your teacher may not provide any configuration. In that case, you make an "empty" virtual environment for the course and you can install any packages you need.

2. Your teacher provides a `requirements.txt` file with a list of packages that are needed (often along with some other required files).

3. Your teacher provides a `pyproject.toml`, again with a list of packages that are needed. This works a little bit differently.

In the next sections we provide instructions for each of these cases.

### Installing an empty virtual environment [nothing]

> Follow these instructions only if you have no `requirements.txt` and no `pyproject.toml` from the course! If you have either of those, skip to the next steps.

From **inside** the course folder, run:

~~~bash
uv venv --python 3.14
~~~

Here, we have added the option `--python 3.14` to specify the version that we just installed. This is useful in case there are multiple Python versions on your computer (and there probably are).

The command creates a `.venv` folder in the course directory. Although it's important to keep it, no need to look at it: the `.venv` folder is managed automatically by `uv`. Therefore:

- do not edit files inside it manually
- do not rename or move it
- do not delete it unless you want to recreate the environment

### Installing with `requirements.txt` [requirements]

From **inside** the course folder, run:

~~~bash
uv venv --python 3.14
~~~

Here, we have added the option `--python 3.14` to specify the version that we just installed. This is useful in case there are multiple Python versions on your computer (and there probably are).

Then run:

~~~bash
uv pip install -r requirements.txt
~~~

This will read the requirements file and install all packages that are mentioned in it.

Note that you now have a `.venv` folder in the course directory. Although it's important to keep it, no need to look at it: the `.venv` folder is managed automatically by `uv`. Therefore:

- do not edit files inside it manually
- do not rename or move it
- do not delete it unless you want to recreate the environment

### Installing with `pyproject.toml` [pyproject]

You may have received a `zip` file for the course or just a single `pyproject.toml`. This file contains a list of the required packages. It can be used to automatically create a virtual environment.

Make sure that you have extracted the files from the zip into an appropriate course folder, or you have placed the downloaded `pyproject.toml`. Then it's just two steps:

~~~bash
cd ~/Nextcloud/programming/course-with-project
uv sync
~~~

The `sync` command will create the virtual environment for you, and install additional packages.

Note that you now have a `.venv` folder in the course directory. Although it must be there, no need to look at it: the `.venv` folder is managed automatically by `uv`. Therefore:

- do not edit files inside it manually
- do not rename or move it
- do not delete it unless you want to recreate the environment

### Before you continue: confirm that the environment exists

After setting up the virtual enviroment, you should now have a folder structure like this:

~~~text
programming/
└── my-course/
    └── .venv/
~~~

Later, your Python files can also live in `my-course`, for example:

~~~text
programming/
└── my-course/
    ├── .venv/
    ├── hello.py
    └── week1.py
~~~


## Running Python programs

Now that everything is installed, you can get into the routine of running your self-written Python programs.


#### Once again: work from inside the course folder

Each time you work on a course, you connect your shell to the course directory (folder). Only then will it pick up on the packages you installed.

So when working of the course you always start with:

1. open a terminal
2. go to your course folder (`cd`)
3. if needed, go to a subfolder
4. run commands from there

And recall, to go to your course folder, use:

~~~bash
cd ~/Nextcloud/programming/my-course
~~~

On Windows PowerShell:

~~~powershell
cd $HOME\Nextcloud\programming\my-course
~~~




## Run commands with `uv run`

When you are inside the course folder, use `uv run` to execute Python and tools.

> This means you do **not** need to activate the virtual environment manually. We mention this because some students may have some experience in using virtual environments. Generally, these have been "activated" for use in the shell. But with `uv run`, we can avoid that for now. Try it!

`uv run` makes sure that:

- the correct Python version for this course is used
- the packages installed in this course’s environment are used
- you do not accidentally use system-wide (global) Python or packages

So that's why you always use the following workflow:

- go to the course folder
- if needed, go to a subfolder that's inside the course folder
- run commands with `uv run`

Example pattern:

~~~bash
uv run <command>
~~~

Normally this would be a Python program that you wrote, like:

~~~bash
uv run hello.py
~~~

That's all! You can use `uv run` every time to run your programs.


## Adding packages to your course environment

A **package** is a collection of Python code written by other people that you can reuse in your own programs.

Instead of writing everything from scratch, you install packages that solve common problems.

Here are some widely used packages you may encounter:

- `requests` – used to download data from the internet (e.g. calling APIs)
- `numpy` – fast numerical computing (arrays, math operations)
- `pandas` – working with tables of data (like spreadsheets)
- `matplotlib` – creating graphs and visualizations
- `rich` – nicer formatting and colors in terminal output

You only install the packages you need for your course.

### Global vs local packages

There are two ways to install Python packages:

- **Global install**: packages are installed once and shared across your whole computer
- **Local install (virtual environment)**: packages are installed only for one course or project

Why global installs are a problem:

- different courses may need different versions of the same package
- installing or upgrading a package can break other projects

Why local installs are better:

- each course has its own setup
- no conflicts between projects
- easier to manage and debug

In this guide, you always install packages **locally inside the course folder**.

### Installing packages into the virtual environment

When you need extra packages for the course, install them from **inside the course folder**.

Example:

~~~bash
cd ~/Nextcloud/programming/my-course
uv pip install requests
~~~

This adds the package to the environment for that course.

You can add more than one package:

~~~bash
uv pip install numpy pandas matplotlib
~~~

#### Adding packages from requirements [requirements]

In case your teacher provided a `requirements.txt` they already had some packages in mind that you need. Run this command once to install the packages into your environment:

~~~bash
cd ~/Nextcloud/programming/my-course
uv pip install -r requirements.txt
~~~

#### Adding packages to a project [pyproject]

If your course works with a `pyproject.toml` you need to add your package to the project using another command:

~~~bash
cd ~/Nextcloud/programming/my-course
uv add rich
~~~

To understand projects with `pyproject.toml` better, read the [Projects guide](https://docs.astral.sh/uv/guides/projects/) on the **uv** website.




## Recommended workflow

For each new course:

- create a new course subfolder inside `~/Nextcloud/programming`
- go into that subfolder create a virtual environment with `uv venv`
- keep your course files there
- use `uv run` from inside that folder
- add packages with `uv pip install ...` when needed

### Example from start to finish

#### macOS and Linux [mac/linux]

~~~bash
mkdir -p ~/Nextcloud/programming/python101
cd ~/Nextcloud/programming/python101
uv venv --python 3.14
uv pip install requests
uv run python
~~~

#### Windows PowerShell [windows]

~~~powershell
mkdir $HOME\Nextcloud\programming\python101
cd $HOME\Nextcloud\programming\python101
uv venv --python 3.14
uv pip install requests
uv run python
~~~

### Common mistakes to avoid

Do not:

- create projects in Downloads or other temporary folders
- install all packages globally
- mix multiple courses in one folder
- forget to move into the course folder before running commands


## Check your installation

Not sure whether everything above actually worked? Paste the command below into your terminal. It checks that `uv` is installed, that it can run a recent enough Python version, and that your `Nextcloud` folder is set up correctly (including the `.venv` exclusion).

#### macOS and Linux [mac/linux]

~~~bash
curl -LsSf https://www.proglab.nl/welkom/install/uv/check.sh | bash
~~~

#### Windows PowerShell [windows]

~~~powershell
irm https://www.proglab.nl/welkom/install/uv/check.ps1 | iex
~~~

If anything is reported as failed or a warning, fix it and run the command again.

This is the end of the tutorial. If you have any questions, do not hesitate to talk to other students, to your teaching assistant, the teacher, or the helpdesk.
