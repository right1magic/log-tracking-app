#!/bin/bash

# 1. 작업 경로 설정
bk_dir="/home/ubuntu/logs"

work_dir="/home/ubuntu/log_backups"
mkdir $work_dir

# 2. 작업 대상 날짜 설정
work_target_ymd=$(date +%F)
mkdir -p $work_dir/$work_target_ymd

# 3. 작업 대상 로그 이동 및 압축 해제
mv "$bk_dir"/logcontroller."$work_target_ymd"_* "$work_dir"/"$work_target_ymd"/

# 4. 로그타입 필터 후 필터링 이전 파일 삭제
aggr_dir="/home/ubuntu/log_aggr"

mkdir -p $aggr_dir
mkdir -p $aggr_dir/$work_target_ymd

for logfile in "$work_dir"/"$work_target_ymd"/log*; do
    filename=$(basename "$logfile")
    cat "$logfile" | grep ^v >> "$aggr_dir"/"$work_target_ymd"/"$filename"
    echo "$logfile" filtering done
    rm "$logfile"
done

# 5. 필터링된 로그 하나의 파일로 병합
file_full="$aggr_dir"/"$work_target_ymd"_merged.log
touch "$file_full"
ls -al "$file_full"

for logfile in "$aggr_dir"/"$work_target_ymd"/*; do
    cat "$logfile" >> "$file_full"
    ls -al "$file_full"
    rm "$logfile"
done
