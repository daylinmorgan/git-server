#!/usr/bin/env python3

from pathlib import Path
import shutil

GITEA_REPOS = Path(__file__).parent / "gitea/git/repositories/daylin"
SOFT_REPOS = Path(__file__).parent / "soft/repos"

allowed = ["dotfiles", "git-server"]
soft_serve_only = ["config"]


def main():

    for repo in GITEA_REPOS.iterdir():
        name = repo.name.replace(".git", "")
        dest = SOFT_REPOS / name
        if name not in [*allowed, *soft_serve_only]:
            continue

        print(f"{repo} >> {dest}")

        if dest.is_dir():
            shutil.rmtree(dest)
        shutil.copytree(repo, dest)

    for repo in SOFT_REPOS.iterdir():
        name = repo.name.replace(".git", "")
        dest = SOFT_REPOS / name
        if name not in [*allowed, *soft_serve_only]:
            print(f"pruning {name}")
            shutil.rmtree(repo)


if __name__ == "__main__":
    main()
