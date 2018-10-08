# Team Lucidify - Git Guide

Team Lucidify uses Git with Gitlab for software configuration management of the senior design project. Git and Gitlab serve the team many excellent use cases that help augment the software development lifecycle:

- Source control - All the source code related to the project can be easily downloaded and edited
- Revision control - A complete history of the revisions made to the project's source code can be viewed
- Code reviews - Team members can request review from other team members through pull requests
- Continuous integration - Gitlab's webhooks can be integrated with Jenkins or other CI/CD pipeline software to automate builds

This document will serve as a go-to guide for the operations the team will need to use during development.

## Installing Git

If you plan on using command-line Git, I recommend installing [Cmder](http://cmder.net/). Cmder is a great Windows cmd emulator that comes prepackaged with many useful tools, including Git.

## Cloning

The first step to writing code for the project is cloning the repository. Cloning copies a code repository from Gitlab to your local disk, including the code and the commit history.

There are two ways to clone a Git repository, SSH and HTTPS. I recommend SSH, because otherwise, you'd have to enter your Gitlab repository every time you push or pull a branch. It takes just a little bit of setup:

1. Open Cmder and run `ssh-keygen`. Follow the prompts, don't use a passphrase, and let it store the key in the default location.
2. From the previous step, copy the default filepath from where it says "Enter the file in which to save the key"
3. Print the public key to stdout by running `cat [path from step 2 + .pub]`
4. Browse to <https://gitlab.com/profile/keys>, paste the public key into the "Key" field and click "Add key"

You can skip these steps if you prefer to clone via HTTPS.

To clone a repository from Gitlab, first find the repository in the web interface. There should be a command in the upper left of the repo "Overview" page with a `git clone [url]` command in it. Copy that into Cmder, first making sure that you're current directory is where you want the repo to be stored on your local disk.

## Branching

Our repositories' master branches are all protected so they can't be directly pushed to. So, in order to make changes, you need to create a branch. `cd` into your repository and run

``` Bash
git checkout -b branch-name
```

This creates a branch and "checks it out" so you can develop on it.

If you want to pull down a branch that already exists, run this:

``` Bash
git fetch
git checkout branch-name
```

This will check out a local branch that tracks the branch of the same name on Gitlab. You can commit to it and push changes up to it.

## Committing

Once you've created and checked out a branch, you can start editing, creating, and deleting files. You can view all the files you have changed by running `git status`. You can view the diff of a file by running `git diff [filename]`. Once you've made the changes you want to commit to the branch, you need to add your files to the staging area. The easiest way to do this is to `cd` to the root of the repo, and run `git add .`. This will recusively add all changed, added, and deleted files in the repo to the staging area. Alternatively, you can add specific files to the staging area using `git add [filename1] [filename2]...`.

Then, commit your files to the branch with `git commit -m "Commit message"`. This saves your changes to the files in the staging area permanently in your local repository.

## Pushing

After you've made one or more commits to your local repo, you can push your changes to a branch in Gitlab. Just run

``` Bash
git push origin branch-name
```

This will create the branch on the remote repository (in Gitlab) if it doesn't already exist, and then pushes up your commits. This way, others who'd like to work on the branch can pull your changes down to their local repos.

## Pulling

Pulling is necessary to get the most recent changes to the repository. Before creating a branch off of the master, you should make sure to pull master first. This way, you ensure you don't get any merge conflicts when it's time to merge your feature/bugfix into the master. Do this by running:

``` Bash
git pull origin master
```

If more than one person is working on the same branch, make sure you pull the latest commits to the branch before beginning work on that branch:

``` Bash
git pull origin branch-name
```

## Merging

Merging is the process of integrating the changes from one branch into another branch, most commonly the master branch. It is possible to merge branches within the Git CLI, but most of the time, we will be merging through the Gitlab web interface. When you have finalized the changes to your feature/bugfix branch and have committed and pushed them, you can create a Merge Request in Gitlab. You can assign reviewers to Merge Requests, who will be presented with the diff between the branch and the master. They can add comments to the diff and/or merge the branches. Commits can be made and pushed to the source branch, which will automatically be added to the Merge Request. This is a great way to facilitate code reviews, as comments can be added to the diff, and they can be resolved by adding commits to the Merge Request.

## Team-Specific Policies

The following are guidelines the team agrees to follow regarding Git and code reviews.

- Features and bugs should be developed in branches off of master. Gitlab repos should be set up to prohibit pushing to the master branch, with the exception of the first commit in new repos.
- In order to get changes into master, a Merge Request should be created.
- All Merge Request creators should request review from one or more other team members.
- Merge Requests should be merged only by reviewers, never by the Merge Request creator.
- Changes to team policies should also undergo the Merge Review process, but all team members should be included as reviewers.
