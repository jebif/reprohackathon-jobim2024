# Data.Trek 2020: Git Tutorial

__Author: Savandara Besse__

_____

## Installation
Depending on your operating system, follow the instructions to install Git from this [web page](https://carpentries.github.io/workshop-template/#git).

______

## Main steps to get started with Git

### 1. Create a GitHub account
Sign up on [GitHub](https://github.com/).

> __Tips__:
> To get your SSH keys and to add them to your SSH agent, take a look [here](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

### 2.	Configure your username and email on Git
The option `--global` will set your username and email for all your Git repositories.

##### a. username
In your terminal / git bash:
1. Set a Git username:

```bash
$ git config --global user.name "Datatrek Team"
```
2. Confirm that you have set your username correctly:

```bash
$ git config --global user.name
> Datatrek Team
```

##### b. email
In your terminal / git bash:

1. Set an email address in Git. You can use your GitHub-provided no-reply email address or any email address.

```bash
$ git config --global user.email "email@example.com"
```

2. Confirm that you have set your email address correctly in Git:

```bash
$ git config --global user.email
> email@example.com
```

### 3.	Create a Git repository and clone it into your local computer

##### a. Git repository
Follow [these guidelines](https://help.github.com/en/github/getting-started-with-github/create-a-repo) to create your first repository.

> __Tips__:
> - Read until this line: “Congratulations! You've successfully created your first repository and initialized it with a README file.”
> - The next part is about making a commit from the web interface.

##### b. Clone to local computer
Next, you would want to clone your repository on your computer. To do so, in your terminal / git bash:
1. Change your working directory to the one where you want your repository to be cloned in with the command `cd TO/YOUR/PATH/FOLDER`
2.	Clone your repository with the command `git clone http://www.github.com/your_repository_url`.
3. Enter in your new folder by using `cd` and check if the content of your repository was adequately created with the command `ls`. This should list all files and subfolders in your repository.

> __Tips__:
> - At this point, nothing should be in your empty repository. You will be creating and modifying files in your projects. An unique README.md file, which depicts the structure and the goal of your project, should at some point be created.
> - The URL is on GitHub on the main page of your repository and can be obtained by clicking on the “Clone or Download" button.

![](01_clone.png)


### 4. Add a new file into your repository and update your Git repo
1.	Create a file in your local repository. In my example, it is the empty file "fake_file.txt".
2.	Type `git add fake_file.txt` in your terminal or git bash. This will “warn” your git that you want to commit a change.
3.	Type `git commit -m “New file”`. This will create a new commit with a short description. Try to be as explicit as you can!
4.	Type `git push` to push your changes to your remote Git repository.

![](02_add_commit_push.png)

> __Tips__:
> -	Always think of committing when you modify a file!  This would allow you to have an useful historic of your changes (_aka. versioning_).
> - Always remember this order: __add / commit / push__.

> -	`git status` will provide you with an overview of what you need to commit.

> - If you are working with someone else, it is important to have the most updated version of your Git repository before pushing.
> -	 `git pull` will help you get the latest version of your remote Git repository from Github (not shown in my example).
> - If there is something new in your Git repository (either because you added something through the web interface or because someone else changed something), the content of the remote repository will be downloaded into your local repository.
> - If nothing has been changed, it will tell you that your repository is up to date.

![](03_status.png)


### 5. Create and work in a branch
Creating a branch is useful when you want to make some tests without modifying the content of your master branch (_aka. the main one_). Also, if you are working in a group, make sure to work on your own branch to not overwrite the code of your teammates! In this example, I will create a branch called "Parallele_branch" and will add a new file in this branch.
1. You can directly create a branch and move to it by writing:
```bash
$ git checkout -b  Parallele_branch
```
2. To switch between your different branches, you can simply write:

```bash
$ git checkout BRANCHNAME ## here master or Parallele_branch
```

![](04_checkout.png)

> __Tips__:
> Have you seen the differences between my two branches?

### 6.	Merge the content of a branch
If you need the file that you added in your second branch in the final version of your code, you need to merge your branch to the master branch.
1. First, you need to come back to the master branch with this command line:
```bash
$ git checkout master
```
2. You can then merge your branch to the master branch with this command line:
```bash
$ git merge Parallele_branch
```

![](05_merge.png)


### 7. Miscellaneous

##### a. Discard your changes and go back to your older version
The easiest way to go back to an older version is the use this command line:

```bash
$ git reset --hard 0ad5a7a6
```
Doing so, you will return to a specific commit (here "0ad5a7a6"). This is particularly useful in the case something went wrong along the way and you want to recover your previous work. You can learn more about undoing things [here](https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/undoing-things).

##### b. Delete a branch
If you want to delete a branch from your local repository, you can use this command line:
```bash
$ git checkout -d Parallele_branch
```
> __Tips__:
>  /!\ Avoid deleting your master branch, tho.


### Acknowledgments
Thanks to @FrancisBanville, @graciellehigino and
@gabrieldansereau for their Git demonstration on Zoom and for their feedbacks on this summary tutorial. 😊

You can view their tutorial on [Youtube](https://www.youtube.com/watch?v=VV1SPh6XK-0) and take a look at their [proposed workflow](https://github.com/Randonnees-Datatrek/data-trek-2020/blob/ef5b5e0f3a0d445be52ca6f305a837a6287d5671/roadmap-demo/script.md). 
