import os
import re
from github import Github, Issue

# Initialize the GitHub API client
g = Github(os.environ["GITHUB_TOKEN"])
repo = g.get_repo(os.environ["GITHUB_REPOSITORY"])

pr_number = os.environ["PULL_REQUEST_NUMBER"]
pr = repo.get_pull(int(pr_number))

changed_files = pr.get_files()

# yes u can do this in a more efficient way, this works fine fk off
# Define directory-label mappings
label_mappings = {
    "src": "backend",
    "templates": "frontend",
    "static": "frontend",
    "test": "test",
    ".github": "ci",
    # Add more mappings as needed
}

# Assign labels based on changed directories
for file in changed_files:
    for directory, label in label_mappings.items():
        if re.match(f"^{directory}/", file.filename):
            pr.add_to_labels(label)
            break