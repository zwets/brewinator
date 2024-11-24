# brewinator/libs

This directory has libraries from https://github.com/adafruit.

Note that origin on helix points to the GitHub upstream master,
whereas on brewinator helix is origin and upstream is GitHub.

On both, branch master tracks the upstream at GitHub.  Branches
zwets track each other (as origin/zwets on brewinator, and 
brewinator/zwets on helix).

## Git workflow

Adding a library on helix:

```bash
# Clone the project and start zwets branch tracking its master
git clone "https://github.com/adafruit/{PROJECT_NAME}.git"
cd {PROJECT_NAME}
git checkout -t -b zwets

# Add the project directory to libs (note: it will be empty when pulled).
# We could add it as a submodule, but those introduce their own issues.
cd ..  # In libs, so on branch 'master' of the main project
git add {PROJECT_NAME}
git commit -am "Add {PROJECT_NAME} library"
```

Setting up on brewinator:

```bash
# Pull the new directory (which will be empty) to brewinator
cd ~/brewinator/libs
git pull  # Creates the *empty* directory {PROJECT_NAME}

# Pull in the helix project, add remote upstream, and switch to origin/zwets
cd {PROJECT_NAME}
git clone helix:Development/raspberrypi/brewinator/libs/$(basename "$PWD") .
git remote add upstream "https://github.com/adafruit/$(basename "$PWD")"
git fetch upstream
git checkout -t upstream/master -b master
git checkout zwets
# Or: git checkout -t origin/zwets -b zwets
```

Updating master on either:

```bash
git checkout master
git pull --ff-only
```

Updating zwets on brewinator from helix:

```bash
cd ~/libs/{PROJECT_NAME}
git checkout zwets
git pull --ff-only
```

Updating zwets on helix from brewinator:

```bash
cd Development/raspberrypi/brewinator/libs/{PROJECT_NAME}
git remote add brewinator brewinator:libs/$(basename "$PWD")
git fetch brewinator
git checkout zwets
git merge --ff-only brewinator/zwets
```

