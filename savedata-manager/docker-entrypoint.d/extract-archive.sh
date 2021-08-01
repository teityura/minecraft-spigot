#!/bin/bash

#===============================================================================
# Usage
# ./extract-archive.sh
#===============================================================================


#===============================================================================
# 対象のアーカイブを取得
#===============================================================================
savedata_latest=`ls /savedata-archives/savedata-*.tar.gz | sort -r | head -1`

if [ ! -n "$savedata_latest" ]; then
    echo 'No such savedata'
    echo 'Please put "savedata-20YYmmddHHMMSS.tar.gz" current directory'
    exit 1
fi

# 手動でアーカイブを指定する場合は、直接変数を上書きしてください
#savedata_latest='/savedata-archives/savedata-20210602021441.tar.gz'

echo -e "savedata_latest: ${savedata_latest}\n"


#===============================================================================
# アーカイブを取り出すディレクトリを指定
#===============================================================================
extracting_dir='/var/server-contents'

if [ ! -d "$extracting_dir" ]; then
    echo "No such ${extracting_dir}"
    exit 1
fi

echo -e "extracting_dir: ${extracting_dir}\n"


#===============================================================================
# アーカイブを取り出すディレクトリを空にする
#===============================================================================
cd "$extracting_dir"
find . | grep -v '^.$' | xargs rm -rf


#===============================================================================
# アーカイブから取り出すファイルを指定
#===============================================================================
extract_files=(
world/
world_nether/
world_the_end/
server.properties
ops.json
whitelist.json
banned-ips.json
banned-players.json
#plugins/
)


#===============================================================================
# アーカイブに存在しないファイルを取得
#===============================================================================
tmp_archived_files='/tmp/archived_files.diff'
tmp_extract_files='/tmp/extract_files.diff'

set -x
tar --exclude='*/*' -tf $savedata_latest | sort | uniq > $tmp_archived_files
set +x
printf "%s\n" ${extract_files[@]} | sort | uniq > $tmp_extract_files
diff_result=`diff -y $tmp_archived_files $tmp_extract_files`
rm -f $tmp_extract_files $tmp_archived_files


#===============================================================================
# アーカイブから指定ファイルを取り出す
#===============================================================================
echo 'extract start =========='
tar xvzf $savedata_latest ${extract_files[@]}
echo -e "extract end ==========\n"

echo 'diff start =========='
echo "diff -y $tmp_extract_files $tmp_archived_files"
echo -e "$diff_result"
echo -e "diff end ==========\n"

echo 'result =========='
ls -ld ${extract_files[@]}
echo 'result =========='

exit 0
