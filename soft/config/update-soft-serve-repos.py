#!/usr/bin/env python3

import json
from pathlib import Path
import shutil


def get_config():
    with (Path(__file__).parent / "soft-serve.config.json").open("r") as f:
        return json.load(f)


def get_name(config, repo):
    name = repo.name.replace(".git", "")
    dest = Path(config["paths"]["dest"]) / name
    return name, dest


def get_repo_path(config, repos):
    return Path(__file__).parent.parent.parent / config["paths"][repos]


def main():

    config = get_config()

    for repo in get_repo_path(config, "src").iterdir():
        name, dest = get_name(config, repo)

        if name not in config["repos"]["src"]:
            continue

        print(f"{repo} >> {dest}")

        if dest.is_dir():
            shutil.rmtree(dest)
        shutil.copytree(repo, dest)

    for repo in get_repo_path(config, "dest").iterdir():
        name, dest = get_name(config, repo)

        if name not in [*config["repos"]["src"], *config["repos"]["dest"]]:
            print(f"pruning {name}")
            shutil.rmtree(repo)


if __name__ == "__main__":
    main()
