#!/bin/bash

echo "=== Шаг 1 и 2: Создание структуры и настройка прав ==="
# Создание папок
mkdir -p claude_monet/warehouse
mkdir -p claude_monet/meat_delivery
mkdir -p claude_monet/fish_delivery
mkdir -p claude_monet/kitchen/hot_station
mkdir -p claude_monet/kitchen/cold_station
mkdir -p claude_monet/office

# Наполнение файлов текстом
echo -e "На складе осталось десять упаковок мяса\nСвежая рыба размещена в холодильнике\nПоставщик зелени ожидается вечером" > claude_monet/warehouse/stock_list
echo -e "Поставщик забрал коробку испорченных овощей\nДве упаковки мяса отправлены на возврат\nБаринов потребовал заменить продукты сегодня" > claude_monet/warehouse/rejection_log
echo -e "Говядина двадцать килограммов\nТелятина десять килограммов\nПоставщик мяса подтвердил вес заказа" > claude_monet/meat_delivery/senya_invoice
echo -e "Доставка мяса задержалась на сорок минут\nСеня принял продукты на складе\nСледующий заказ привезут утром" > claude_monet/meat_delivery/supplier_note
echo -e "Сибас двенадцать штук\nДорадо восемь штук\nПоставщик рыбы добавил коробку льда" > claude_monet/fish_delivery/fedya_invoice
echo -e "Рыба имеет свежий запах\nТемпература при доставке не нарушена\nФедя разрешил использовать весь заказ" > claude_monet/fish_delivery/freshness_report
echo -e "Баринов недоволен опозданием машины\nШеф требует проверять каждого поставщика\nКачество продуктов важнее скидки" > claude_monet/kitchen/hot_station/barinov_claim
echo -e "Для банкета требуется свежая рыба\nФедя выбрал сибаса и дорадо\nЗаказ нужно передать Вике" > claude_monet/kitchen/cold_station/fish_order
echo -e "Вика получила накладные от Сени и Феди\nОплата поставщикам назначена на вечер\nВозврат продуктов вычитается из суммы" > claude_monet/office/vika_payment
echo -e "Поставщик позвонил перед открытием ресторана\nМашина с продуктами стоит у входа\nЛёва должен открыть склад" > delivery_call

# Права доступа
chmod 755 claude_monet
chmod u=rw,g=r,o= delivery_call
chmod u=rwx,g=rx,o= claude_monet/warehouse
chmod 640 claude_monet/warehouse/stock_list
chmod u=rw,g=r,o= claude_monet/warehouse/rejection_log
chmod 750 claude_monet/meat_delivery
chmod u=rw,g=r,o= claude_monet/meat_delivery/senya_invoice
chmod 644 claude_monet/meat_delivery/supplier_note
chmod u=rwx,g=rx,o= claude_monet/fish_delivery
chmod 640 claude_monet/fish_delivery/fedya_invoice
chmod u=rw,g=r,o=r claude_monet/fish_delivery/freshness_report
chmod 750 claude_monet/kitchen
chmod u=rwx,g=rx,o= claude_monet/kitchen/hot_station
chmod 640 claude_monet/kitchen/hot_station/barinov_claim
chmod u=rwx,g=rx,o= claude_monet/kitchen/cold_station
chmod u=rw,g=r,o= claude_monet/kitchen/cold_station/fish_order
chmod 750 claude_monet/office
chmod 640 claude_monet/office/vika_payment

echo "=== Шаг 3 и 4: Копирование, ссылки и фильтрация ==="
# Воспроизводим операции копирования и создания ссылок, которые были до удаления
# (Опираясь на лог удаления Git: дубликаты, бэкапы рыбы и символические ссылки)
mkdir -p claude_monet/warehouse/fish_backup
cp claude_monet/fish_delivery/fedya_invoice claude_monet/warehouse/fish_backup/
cp claude_monet/fish_delivery/freshness_report claude_monet/warehouse/fish_backup/
cp claude_monet/meat_delivery/senya_invoice claude_monet/meat_delivery/invoice_duplicate
ln -s claude_monet/office/vika_payment stock_link 2>/dev/null

echo "=== Шаг 5: Очистка, фильтрация и удаление объектов ==="
# Команды удаления из вашей истории терминала:
rm -f claude_monet/warehouse/rejection_log
rm -rf claude_monet/warehouse/fish_backup

echo "Выполнение всех пунктов лабораторной работы успешно автоматизировано!"
