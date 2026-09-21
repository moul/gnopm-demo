# gnopm-demo

[![packages in this workspace](https://img.shields.io/badge/packages-6-blue)](https://github.com/moul/gnopm) [![resolvable module paths](https://img.shields.io/badge/modules-9-blue)](https://github.com/moul/gnopm) [![versions kept in the lock](https://img.shields.io/badge/pinned-3-8957e5)](https://github.com/moul/gnopm) [![managed by gnopm](https://img.shields.io/badge/gnopm-managed-7ee787)](https://github.com/moul/gnopm)

**Generated. Rewritten from scratch on every run. Do not send pull requests here.**

This repository is the worked example for
[**gnopm**](https://github.com/moul/gnopm), a
package manager for gno workspaces that keeps a package's version in its
`gnomod.toml` instead of in its directory name.

It is produced by `tools/gnopm/scripts/demo.sh`, which is also gnopm's
integration test: every claim below is asserted by the script that wrote this
file, so if the tool stops behaving this way the script fails rather than
quietly producing a misleading demo.

## Read it as a history, not as a tree

```
git log --reverse --stat
```

The commits tell one story in three acts.

**Act 1, the old layout.** Each version gets its own directory. Watch the
commit that bumps `strs` to v1: it is a pure addition, nothing removed, because
git cannot pair a copied directory. The compatibility change in that commit,
`Repeat` growing an `error` return, is invisible in the diff. That is the
problem.

**Act 2, the migration.** One command, `gnopm deversion`. Every file moves with
`git mv`, so the whole thing is recorded as `R100` renames and reviews as a
rename list. No module line is touched, so no package path and no realm address
changes. `strs/v0`, which had been superseded, stops having a directory and is
pinned in `gnomod.lock` to the commit that still holds it.

**Act 3, ordinary work.** A new package added without a version in its path. A
bump that is one line in `gnomod.toml` followed by the real content diff in the
same file. A version skipped with `-to`. A superseded version still resolving,
still carrying its old signature, for the realm that still imports it.

## What is where

| | |
|---|---|
| `p/demo/strs/` | a leaf package, now at v1; v0 lives only in the lock |
| `p/demo/table/` | depends on `strs` and on a vendored external package |
| `p/demo/math/bignum/` | a nested path: the version is always the LAST element |
| `p/demo/set/` | added after the migration, so it never had a `v0/` directory |
| `r/demo/board/` | a realm pinning two different versions at once |
| `vendor/` | third-party code, committed, deliberately outside gnopm's scope |
| `gnomod.lock` | where every version's source is. Committed: it is source, not a generated artifact |
| `.gnopm/` | superseded versions, rebuilt from history. Gitignored |

## Try it

```
gnopm status          # what resolves, and whether anything is out of date
gnopm ls              # every module and where its source is
gnopm ls -pinned      # just the ones with no directory any more
gnopm verify          # prove every pinned version still reproduces
gnopm bump set        # one line, then edit the files in place
```

## CI

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) is the whole of this
repository's CI. It installs gnopm and runs `gnopm tool ci --comment`, which
checks that the lock describes the tree, that every pinned version reproduces
from history, and that no pin would be discarded by a squash merge, then keeps
one pull request comment up to date with the result.

Nothing in it is specific to this repository: the checks live in the gnopm
binary, so adopting them is installing gnopm rather than copying a workflow.

The badges at the top come from `gnopm badges`.
