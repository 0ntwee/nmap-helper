#!/bin/bash

# Функция для вывода заголовка
header() {
    clear
    echo "====================================="
    echo "Nmap Automation Script"
    echo "====================================="
    echo
}

# Функция для выбора типа сканирования
choose_scan_type() {
    header
    echo "Выберите тип сканирования:"
    echo "1) Быстрое сканирование (Top 100 портов)"
    echo "2) Полное сканирование (Все порты)"
    echo "3) Сканирование UDP портов"
    echo "4) Сканирование с определением ОС и сервисов"
    echo "5) Безопасное сканирование (без сохранения в файл)"
    echo "6) Сканирование уязвимостей (с использованием NSE)"
    echo "7) Пользовательское сканирование"
    echo "8) Выход"
    echo
    read -p "Введите номер [1-8]: " scan_choice

    case $scan_choice in
        1) 
            SCAN_TYPE="-T4 -F"
            SCAN_NAME="quick_scan"
            ;;
        2) 
            SCAN_TYPE="-p- -T4"
            SCAN_NAME="full_scan"
            ;;
        3) 
            SCAN_TYPE="-sU -T4"
            SCAN_NAME="udp_scan"
            ;;
        4) 
            SCAN_TYPE="-A -T4"
            SCAN_NAME="os_service_scan"
            ;;
        5) 
            SCAN_TYPE="-T4"
            SCAN_NAME="safe_scan"
            NO_OUTPUT=true
            ;;
        6) 
            SCAN_TYPE="--script=vuln -T4"
            SCAN_NAME="vuln_scan"
            ;;
        7) 
            read -p "Введите свои опции nmap: " custom_scan
            SCAN_TYPE=$custom_scan
            SCAN_NAME="custom_scan"
            ;;
        8) 
            echo "Выход..."
            exit 0
            ;;
        *) 
            echo "Неверный выбор, попробуйте снова."
            sleep 2
            choose_scan_type
            ;;
    esac
}

# Функция для выбора цели
choose_target() {
    header
    echo "Выберите цель сканирования:"
    echo "1) Одиночный IP"
    echo "2) Диапазон IP"
    echo "3) Список IP из файла"
    echo "4) Доменное имя"
    echo "5) Вернуться назад"
    echo
    read -p "Введите номер [1-5]: " target_choice

    case $target_choice in
        1) 
            read -p "Введите IP адрес: " target
            TARGET=$target
            ;;
        2) 
            read -p "Введите диапазон IP (например, 192.168.1.1-100): " target
            TARGET=$target
            ;;
        3) 
            read -p "Введите путь к файлу с IP адресами: " target_file
            if [ -f "$target_file" ]; then
                TARGET="-iL $target_file"
            else
                echo "Файл не найден!"
                sleep 2
                choose_target
            fi
            ;;
        4) 
            read -p "Введите доменное имя: " target
            TARGET=$target
            ;;
        5) 
            choose_scan_type
            ;;
        *) 
            echo "Неверный выбор, попробуйте снова."
            sleep 2
            choose_target
            ;;
    esac
}

# Функция для выполнения сканирования
run_scan() {
    header
    echo "Сканирование запущено..."
    echo "Тип: $SCAN_NAME"
    echo "Цель: $TARGET"
    echo "Команда: nmap $SCAN_TYPE $TARGET"
    echo

    if [ "$NO_OUTPUT" = true ]; then
        nmap $SCAN_TYPE $TARGET
    else
        OUTPUT_FILE="${SCAN_NAME}_$(date +%Y%m%d_%H%M%S).txt"
        nmap $SCAN_TYPE $TARGET -oN $OUTPUT_FILE
        echo
        echo "Результаты сохранены в $OUTPUT_FILE"
    fi
}

# Главная функция
main() {
    while true; do
        choose_scan_type
        choose_target
        run_scan
        
        read -p "Хотите выполнить еще одно сканирование? (y/n): " again
        if [[ ! $again =~ ^[YyДд]$ ]]; then
            break
        fi
    done
    
    echo "Скрипт завершен."
}

# Запуск скрипта
main
