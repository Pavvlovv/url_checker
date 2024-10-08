#!/bin/bash

check_urls() {
  local file="$1"
  while IFS= read -r url; do
    if curl --silent --output /dev/null --fail "$url" &> /dev/null; then
      # Если curl выполнился успешно, выводим подробную информацию
      status_code=$(curl --write-out %{http_code} --silent "$url")
      echo "URL $url доступен (код ответа: $status_code)"
    else
      echo "Ошибка при проверке URL $url"
    fi
  done < "$file"
}

check_urls "/urls.txt"