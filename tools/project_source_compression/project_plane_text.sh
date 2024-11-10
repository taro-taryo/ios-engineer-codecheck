#!/bin/bash

show_help() {
  cat <<EOF
使用方法: $(basename "$0") [オプション]

オプション:
  -s, --source-dir DIR      コピー対象のディレクトリ（デフォルト: カレントディレクトリ）
  -o, --output-file FILE    出力ファイル。指定しない場合、標準出力に出力します。
  -t, --tmp-dir DIR         一時ディレクトリ（デフォルト: tmp_swift_source）
  -c, --config FILE         swift-format 設定ファイル（デフォルト: ./swift-format-configuration-compact）
  -d, --debug               デバッグ情報を表示
  -h, --help                このヘルプを表示

例:
  $(basename "$0") -s "/path/to/source" -o "output.txt" -t "temp_dir" -c "./tools/custom-swift-format-config"
EOF
}

# デフォルト設定
SOURCE_DIR=""
TMP_DIR="tmp_swift_source"
CONFIG_FILE="./swift-format-configuration-compact"
DEBUG=0
OUTPUT_FILE=""

# 引数がない場合の処理
if [[ $# -eq 0 ]]; then
  show_help
  exit 0
fi

# 引数の処理
while [[ $# -gt 0 ]]; do
  case $1 in
    -s|--source-dir)
      SOURCE_DIR="$2"
      shift 2
      ;;
    -o|--output-file)
      OUTPUT_FILE="$2"
      shift 2
      ;;
    -t|--tmp-dir)
      TMP_DIR="$2"
      shift 2
      ;;
    -c|--config)
      CONFIG_FILE="$2"
      shift 2
      ;;
    -d|--debug)
      DEBUG=1
      shift
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "無効なオプションです: $1"
      show_help
      exit 1
      ;;
  esac
done

# SOURCE_DIR のデフォルト設定
if [[ -z $SOURCE_DIR ]]; then
  SOURCE_DIR=$(pwd)
fi

# デバッグ出力用関数
debug_log() {
  if [[ $DEBUG -eq 1 ]]; then
    echo "$1"
  fi
}

# 出力ファイルと一時ディレクトリの準備
debug_log "Preparing directories and files..."
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
if [[ -n $OUTPUT_FILE ]]; then
  > "$OUTPUT_FILE"
fi

# .swift ファイルのコピー
debug_log "Starting to copy .swift files from $SOURCE_DIR to $TMP_DIR ..."
find "$SOURCE_DIR" -name "*.swift" | while read -r filepath; do
  relative_path="${filepath#$SOURCE_DIR/}"
  target_dir="$TMP_DIR/$(dirname "$relative_path")"
  debug_log "Copying $filepath to $target_dir"
  mkdir -p "$target_dir"
  cp "$filepath" "$target_dir/"
done
debug_log "Copying completed."

# swift-format 適用
debug_log "Starting swift-format processing with configuration $CONFIG_FILE..."
swift format -r "$TMP_DIR" -i --configuration "$CONFIG_FILE"

# フォーマット済みファイルの出力
output_content() {
  relative_path="$1"
  content="$2"
  echo "$relative_path"
  echo '```'
  echo "$content"
  echo '```'
  echo ""
}

# 出力ファイルへの書き込み or 標準出力
find "$TMP_DIR" -name "*.swift" | while read -r file; do
  formatted_content=$(cat "$file" | sed '/^\/\//d')
  if [[ -z $formatted_content ]]; then
    debug_log "swift-format failed or returned empty content for $file"
    continue
  fi
  relative_path="${file#$TMP_DIR/}"
  if [[ -n $OUTPUT_FILE ]]; then
    {
      echo "$relative_path"
      echo '```'
      echo "$formatted_content"
      echo '```'
      echo ""
    } >> "$OUTPUT_FILE"
  else
    output_content "$relative_path" "$formatted_content"
  fi
done

debug_log "swift-format processing completed."
if [[ -n $OUTPUT_FILE ]]; then
  debug_log "Formatted content has been output to $OUTPUT_FILE."
else
  debug_log "Formatted content has been output to standard output."
fi
