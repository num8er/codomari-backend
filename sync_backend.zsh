#!/bin/zsh

# Variables
LOCAL_DIR="/Users/num8er/My/Codomari/codomari_backend/"
REMOTE_USER="num8er"
REMOTE_HOST="srv0.codomari.com" # e.g., example.com or an IP address
REMOTE_DIR="/apps/codomari_backend"

# Rsync command
rsync -avz --delete \
    --exclude-from=".sync_backend.exclude" \
    "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# Explanation of options:
# -a: Archive mode (preserves permissions, timestamps, symbolic links, etc.)
# -v: Verbose output
# -z: Compress data during transfer
# --delete: Deletes files on the destination that are not in the source
# --exclude-from="exclusion list file": Exclude files and directories listed in the specified file

VERSION=$(grep -E 'version:' lib/codomari_backend.ex | sed -E "s/.*version: \"([^\"]+)\".*/\1/")

ssh -t $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_DIR ; rm -rf deps && mix deps.get"
ssh -t $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_DIR ; MIX_ENV=dev mix release codomari_backend --overwrite --path _releases --version $VERSION"
ssh -t $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_DIR ; rm -rf _releases/$VERSION ; mkdir _releases/$VERSION ; cd _releases ; tar -zxf codomari_backend-$VERSION.tar.gz -C $VERSION"
ssh -t $REMOTE_USER@$REMOTE_HOST "cd $REMOTE_DIR ; cd _releases/$VERSION ; ./bin/codomari_backend stop ; sleep 1 ; ./bin/codomari_backend daemon"
