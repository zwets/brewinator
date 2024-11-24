# brewinator.git

This is git repository helix:Development/raspberrypi/brewinator.

* libs     - upstream libraries used in the projects
* notes    - zwets's log (refer to notes/README.md)
* projects - stuff built by zwets

Note that the libs have upstreams on GitHub.  Local modifications
are on the 'zwets' branch.  See `libs/README.md`.

## Git workflow (non-libs)

Pulling on brewinator from helix:

```bash
git checkout master  # the non-libs are on master
git pull --ff-only
```

Pulling on helix from brewinator:

```bash
git add remote brewinator brewinator:
git fetch brewinator
git merge --ff-only brewinator
```

## Git workflow (libs)

See `libs/README.md`.

