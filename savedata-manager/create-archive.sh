#!/bin/bash

#===============================================================================
# Usage
# ./create-archive.sh [archiving_dir] [save_location]
#===============================================================================


#===============================================================================
# アーカイブを作成するディレクトリを指定
#===============================================================================
archiving_dir=${1:-/var/server-contents}

if [ ! -d "$archiving_dir" ]; then
    echo "No such ${archiving_dir}"
    exit 1
fi

echo -e "archiving_dir: ${archiving_dir}\n"


#===============================================================================
# アーカイブを保存するディレクトリを指定
#===============================================================================
save_location=${2:-/savedata-archives}

if [ ! -d "$save_location" ]; then
    echo "No such ${save_location}"
    exit 1
fi

echo -e "save_location: ${save_location}\n"


#===============================================================================
# アーカイブするファイルを指定
#===============================================================================
archive_files=(
world/
world_nether/
world_the_end/
server.properties
ops.json
whitelist.json
banned-ips.json
banned-players.json
plugins/
)


#===============================================================================
# アーカイブを作成するディレクトリに存在しないファイルを取得
#===============================================================================
tmp_archive_files='/tmp/archive_files.diff'
tmp_exist_files='/tmp/exist_files.diff'

cd $archiving_dir
printf "%s\n" ${archive_files[@]} | sort | uniq > $tmp_archive_files
ls -d ${archive_files[@]} 2>/dev/null | sort | uniq > $tmp_exist_files
diff_result=`diff -y $tmp_archive_files $tmp_exist_files`
rm -f $tmp_archive_files $tmp_exist_files


#===============================================================================
# アーカイブから指定ファイルを取り出す
#===============================================================================
echo 'archive start =========='
filename="savedata-`date '+%Y%m%d%H%M%S'`.tar.gz"
archive_path="${save_location}/${filename}"
tar cvzf $archive_path ${archive_files[@]}
echo -e "archive end ==========\n"

echo 'diff start =========='
echo "diff -y $tmp_archive_files $tmp_exist_files"
echo -e "$diff_result"
echo -e "diff end ==========\n"

echo 'result =========='
ls -ld $archive_path
echo 'result =========='

exit 0
