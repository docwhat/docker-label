#!/bin/bash

set -eEuo pipefail

typeset -a labels=()

add() {
  labels+=("$1=$2")
}

add org.opencontainers.image.created "$(date -u '+%Y-%m-%d %H:%M:%S+00:00')"

add org.opencontainers.image.revision "$(git rev-parse HEAD)"
add org.opencontainers.image.authors "$(git log --pretty=format:'%an,' | sort | uniq -i | sed 's/,*$//')"

if git describe --tags --exact-match >/dev/null 2>&1; then
  add org.opencontainers.image.version "$(git describe --tags --exact-match)"
fi

# TODO: handle non-origin remotes
add org.opencontainers.image.source "$(git remote get-url origin)"

# add org.opencontainers.image.authors
# contact details of the people or organization responsible for the image (freeform string)
# org.opencontainers.image.url URL to find more information on the image (string)
# org.opencontainers.image.documentation URL to get documentation on the image (string)
# org.opencontainers.image.source URL to get source code for building the image (string)
# org.opencontainers.image.version version of the packaged software

#     The version MAY match a label or tag in the source code repository
#     version MAY be Semantic versioning-compatible

# org.opencontainers.image.vendor Name of the distributing entity, organization or individual.
# org.opencontainers.image.licenses License(s) under which contained software is distributed as an SPDX License Expression.
# org.opencontainers.image.ref.name Name of the reference for a target (string).

#     SHOULD only be considered valid when on descriptors on index.json within image layout.
#     Character set of the value SHOULD conform to alphanum of A-Za-z0-9 and separator set of -._:@/+
#     The reference must match the following grammar:

#     ref       ::= component ("/" component)*
#     component ::= alphanum (separator alphanum)*
#     alphanum  ::= [A-Za-z0-9]+
#     separator ::= [-._:@+] | "--"

# org.opencontainers.image.title Human-readable title of the image (string)
# org.opencontainers.image.description

for label in "${labels[@]}"; do
  echo "--label=${label}"
done
