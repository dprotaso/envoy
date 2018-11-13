#!/usr/bin/env python

# Quick-and-dirty Python to fetch git repository info in bazel/repository_locations.bzl.

import imp
import json
import os.path
import re

locs = imp.load_source('replocs', 'bazel/repository_locations.bzl')
recipes = imp.load_source('replocs', 'bazel/target_recipes.bzl')
recipe_versions_file = 'ci/build_container/build_recipes/versions.sh'

def parse_recipe_details(name, text):
    info = {}

    # Remove dashes
    prefix = name.upper().translate(None, '-')
    scans = {
            prefix + '_GIT_REPO' : 'git-repo',
            prefix + '_GIT_SHA' : 'git-sha',
            prefix + '_FILE_SHA256' : 'file-sha256',
            prefix + '_FILE_URL' : 'file-url',
     }


    for env_var, json_key in scans.items():
        m = re.search(env_var + '=(.*)', text)

        if m:
            info[json_key] = m.group(1)
            os.environ[env_var] = m.group(1)

    # Expand any of the env vars
    for key, value in info.items():
        info[key] = os.path.expandvars(value)


    return info

if __name__ == '__main__':
    deps = []

    with open(recipe_versions_file, 'r') as raw:
        recipe_versions = raw.read()

    for key, loc in locs.REPOSITORY_LOCATIONS.items():
        deps.append({
            'identifier': key,
            'git-repo': loc.get('git_repo'),
            'git-sha': loc.get('git_sha'),
            'file-sha256': loc.get('sha256'),
            'file-url': loc.get('urls')[0],
        })

    for key, name in recipes.TARGET_RECIPES.items():
        info = parse_recipe_details(name, recipe_versions)
        info['identifier'] = key
        deps.append(info)

    print json.dumps(deps, sort_keys=True)
