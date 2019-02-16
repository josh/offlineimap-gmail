#!/bin/bash

if [[ -n "$EMAIL" && -n "$PASSWORD" ]]; then
  cat <<EOF > ~/.netrc
machine imap.gmail.com
  login $EMAIL
  password $PASSWORD
EOF
  chmod 600 ~/.netrc
fi

exec tickerd -- offlineimap "$@"
