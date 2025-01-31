#!/bin/bash
# 脚本名称：Termux 备份脚本
# 脚本作者：@zjw
# 脚本版本：1.0
# 脚本描述：备份 Termux 中/data/data/com.termux/files 目录下的./home ./usr目录 ，并保留最近两个备份，删除旧的备份。

# 备份存储目录以及保留的备份数量
BACKUP_DIR="/sdcard/Download/termux-backup"
SAVE_BACKUP_COUNT=2

# 确保目录存在
mkdir -p "$BACKUP_DIR"

# 生成备份文件名
DATE=$(date +"%Y%m%d%H%M")
BACKUP_FILE="$BACKUP_DIR/termux-backup-$DATE.tar.gz"

# 检查 Termux 是否具有存储权限
echo "checking for storage permission."
if [ ! -d "$HOME/storage/shared" ]; then
    echo "Termux does not have storage permission."
    echo "Requesting storage permission..."
    termux-setup-storage
    echo "Please click 'Allow' in the pop-up dialog, then press Enter to continue..."
    read -r  # Wait for user to press Enter
fi

# 再次检查权限
if [ ! -d "$HOME/storage/shared" ]; then
    echo "Error: Storage permission not granted. The script cannot continue."
    exit 1
else
    echo "Storage permission granted. Continuing with backup..."
fi

# 执行备份
if ! tar -zcf "$BACKUP_FILE" -C /data/data/com.termux/files \
	--exclude=./home/.suroot \
	--exclude=./usr/var/run/* \
	./home ./usr; then
    	echo "Backup failed: $BACKUP_FILE"
	exit 1
fi

# 获取文件大小（M 或 G）
FILE_SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')

# 记录日志
LOG_FILE="$(dirname "$0")/backup.log"
echo "$(date +"%Y-%m-%d %H:%M:%S") | $BACKUP_FILE | $FILE_SIZE" | tee -a "$LOG_FILE"

# 只保留最近两个备份，删除旧的
cd "$BACKUP_DIR" || exit 1  # Exit if directory does not exist

# 获取备份文件列表并按时间排序
BACKUP_FILES=$(ls -t termux-backup-*.tar.gz 2>/dev/null)

if [ -n "$BACKUP_FILES" ]; then
    BACKUP_COUNT=$(echo "$BACKUP_FILES" | wc -l)

    if ((BACKUP_COUNT > SAVE_BACKUP_COUNT)); then
        # 计算需要删除的文件数量
        DELETE_COUNT=$((BACKUP_COUNT - SAVE_BACKUP_COUNT))
        # 删除多余的旧文件
        echo "$BACKUP_FILES" | tail -n "$DELETE_COUNT" | xargs -r rm -f
    fi
else
    echo "No backup files found."
fi
