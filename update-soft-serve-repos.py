#!/usr/bin/env python3

from pathlib import Path
import shutil

GITEA_REPOS = Path(__file__).parent / "gitea/git/repositories/daylin"
SOFT_REPOS = Path(__file__).parent / "soft/repos"

allowed = ["dotfiles", "gitea-server"]


def main():

    for repo in GITEA_REPOS.iterdir():
        name = repo.name.replace(".git", "")
        if name not in allowed:
            continue
        print(repo)

        dest = SOFT_REPOS / name
        print(f">> {dest}")

        if dest.is_dir():
            shutil.rmtree(dest)
        shutil.copytree(repo, dest)


if __name__ == "__main__":
    main()
