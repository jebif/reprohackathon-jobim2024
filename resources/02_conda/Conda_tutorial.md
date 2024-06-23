# JEBiF@JOBIM: Conda Tutorial

## **Conda overview**

Conda is a package and environment for python. It has two main advantages over the classique python package manager **pip**:

1. Built-in virtual environment creation 
2. Integration of non-python packages
A virtual environment managed by conda can use packages from different languages, which is useful for data analysis pipelines that combine R and python scripts for example. 

> It is possible to use conda for any language, which makes it an all-around great addition in the bioinformatician's toolbelt.

## **Shortcomings**

Nothing is perfect, and conda is far from being an exception. 

For starters, any package installed in a conda environment but not by conda will not be considered as installed by the manager, which can impair the reproducibility of a project. 

For example, packages installed by pip or the R function `install.packages()` would not be exported by the command `conda env export` which is supposed to export all packages installed in the environment to ensure reproducibility of a code. 

> Thus, inside a conda environment, you should never use anything else to install packages.

The second drawback of conda is that starting from medium-sized projects, the dependency resolution takes an eternity and a half. 

Dependency resolution is an essential aspect of any package manager, as it is the mechanism preventing the installation of incompatible libraries, which would utterly break the environment. 

> - To answer this problem, **mamba** was created. 
> - As of the latest versions of conda, default solver is **libmamba**, a faster dependency solver that drastically increases the speed of dependency resolution.

____

<br>


## 1. Installation

For this tutorial, we will install **miniconda**. It is a minimal installer that has all the core functionality of conda without all the junk and superfluous packages bundled with the main **Anaconda** distribution. 

> If you already have a conda installation, you can skip this step.

To manually install conda go to [this page](https://docs.anaconda.com/free/miniconda/) and click on your version.
To install through the command line, run the following commands (`~/miniconda` can be replaced by the folder of your choice):

```bash
mkdir -p ~/miniconda3

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

rm -rf ~/miniconda3/miniconda.sh
```

Then, initialize conda for your shell. If you are using bash:

```bash
~/miniconda3/bin/conda init bash
```
For zsh:

```zsh
~/miniconda3/bin/conda init zsh
```

You're all set! Make sure conda is properly installed with:

```bash
conda -V
```

## 2. Create and activate a virtual environment

Once conda is installed, you should avoid as much as much as possible to install any package in your base environment. 

> This is a general advice, not a conda requirement. 

Since virtual environments have access to the packages in the base environment, any conflict between them is allways a pain to resolve.

You can create a new conda environment with either a name or a path. When you create an environment with a name, its files will be located in the installation folder (if you let the default installation path, that would be `~/miniconda3/envs/[env name]`). With a prefix, you have to spell the full path of the conda environment. The last element of the path is the name of the environment.

With a name:
```bash
conda create -n my_env
```
With a prefix:
```bash
conda create -p /path/to/my_env
```
> Important: When using `-p`, don't end the path with a slash `/`. It will work well, but the environment name will be blank, as the last element is everything *after* the last slash.

<br>

If you have a file named `env.yml` or `environment.yml`, you can create a new environment already populated with packages by passing the `--file` argument:

```bash
conda create -n my_env --file=env.yml
```

For more options, see the [conda create documentation](https://docs.conda.io/projects/conda/en/latest/commands/create.html).

Then, to activate you environment, run the following command:

```bash
conda activate my_env
```

You should then see an indication that you're in a virtual environment like so:

```bash
(my_env) Hoo@Hoo:~$
```

To exit the virtual environment, simply run `conda deactivate`.

## 3. Install packages with conda

To install a package inside an environment, simply run the command:

```bash
conda install -c conda-forge [package-name]
```

The `-c conda-forge` tells conda to look into the **conda-forge** channel, which it does not by default. This channel has many packages, and most of the tools you would need to use, wether in python or R, can be found there.

If you need a specific version of a package, you can do so by specifying with an operator:
```bash
# Install the exact version 1.2.3
conda install -c conda-forge package=1.2.3

# Install the newest version BEFORE 2.0.0
conda install -c conda-forge package<2.0.0

# Install version 3.6 or newest
conda install -c conda-forge package>=3.6
```

Naturally, you can install multiple packages in one command, with or without version specification:
```bash
conda install -c conda-forge package1 package2=1.0.0 package3<0.90
```

___

<br>

## **About Reproducibility**

Beside isolating the processes, a key advantage of virtual environments is their reproducibility. To share your environment with someone else, you need to generate a file called by convention `env.yml` which contains all the packages and their exact versions. You can specify a different name, though try not to be too extravagant. To get this file, run:

```bash
conda env export -f env.yml
```

The -f argument is optional, and used to specify a file name.

___

<br>

### **Authorship & Acknowledgments**

- Written by XXXX (?)

- Reviewed for JEBif@JOBIM 2024 by Savandara Besse (@ladyson1806) 

>_Last modification: 06-23-2024_


