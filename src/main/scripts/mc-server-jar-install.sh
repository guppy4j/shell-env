#! /bin/sh -x

usage() {
  echo "Usage: $(basename $0) version"
}

test $# -ne 1 && usage && exit 2

version=$1

page="https://mcversions.net/download/$version"
pattern="https://launcher.mojang.com/v1/objects/.*/server.jar"
jar="minecraft_server.$version.jar"

server_jar_url="$(wget -O - "$page" | grep -o "$pattern")"

# set shell option for exit on error behavior
set -e

cd /opt/minecraft-server/
wget -O "$jar" "$server_jar_url"
chown minecraft.minecraft "$jar"

service minecraft stop

rm -f server.jar; ln -s "$jar" server.jar

service minecraft start
