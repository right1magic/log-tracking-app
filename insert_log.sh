#!/bin/bash

# MySQL 접속 정보
MYSQL_HOST="1bc8cc38-e15d-4308-9512-cf3a4cdf975a.internal.kr1.mysql.rds.nhncloudservice.com"  # MySQL 서버의 엔드포인트 또는 IP 주소
MYSQL_USER="log_admin"      # MySQL 사용자명
MYSQL_PASSWORD="log_admin"  # MySQL 비밀번호
MYSQL_DATABASE="log_backup"   # 스키마명 (데이터베이스 이름)
MYSQL_TABLE="app_logs"      # 삽입할 테이블명

# 로그 파일
LOG_FILE="home/ubuntu/log.log"

# 로그 파일을 한 줄씩 읽어서 처리
while IFS=$',' read -r logtype logdate loguser logendpoint; do
    mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -P 3306 -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e \
    "INSERT INTO $MYSQL_TABLE VALUES ('$id', '$log_type', '$log_timestamp', '$url', '$method', '$user_id', '$transaction_id',
    '$product_id', '$cart_id', '$order_id', '$payload', '$client_ip', '$user_agent', '$referer');"
done < "$LOG_FILE"
