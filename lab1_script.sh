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
cp delivery_call claude_monet/office/call_copy
cp -r claude_monet/fish_delivery claude_monet/warehouse/fish_backup
ln -s claude_monet/warehouse/stock_list stock_link
ln -s ../warehouse claude_monet/kitchen/warehouse_access
ln claude_monet/meat_delivery/senya_invoice claude_monet/meat_delivery/invoice_duplicate
cat claude_monet/meat_delivery/senya_invoice claude_monet/fish_delivery/fedya_invoice > claude_monet/warehouse/all_invoices
cat claude_monet/warehouse/rejection_log >> claude_monet/kitchen/hot_station/barinov_claim
mv claude_monet/kitchen/cold_station/fish_order claude_monet/office/urgent_fish_order

ls -lR 2>/dev/null | grep "^-" | grep -v "copy" | sort -k5 -n | tail -n 5
grep -riIh -e "поставщик" -e "продукт" claude_monet | grep -vi "утром" | sort | head -n 6
grep -rl "рыб" claude_monet/fish_delivery claude_monet/warehouse/fish_backup 2>/dev/null | wc -l
tail -n 2 claude_monet/meat_delivery/*_invoice claude_monet/fish_delivery/*_invoice 2>/dev/null | grep -v "==>" | grep -iE
grep -vi "поставщик" claude_monet/warehouse/all_invoices | sort -r | head -n 3 | wc -w
ls -lR 2>/dev/null | grep "^-" | awk '$2 == 2 {print}' | sort -k1 -n
ls -lR 2>/dev/null | grep "^l" | sort -k9 | tail -n 1

echo "=== Шаг 5: Очистка, фильтрация и удаление объектов ==="
# Команды удаления из вашей истории терминала:
rm claude_monet/office/call_copy
rm stock_link
rm claude_monet/kitchen/warehouse_access
rm claude_monet/meat_delivery/invoice_duplicate
rm claude_monet/office/urgent_fish_order
rmdir claude_monet/kitchen/cold_station
rm claude_monet/warehouse/rejection_log
rm -rf claude_monet/warehouse/fish_backup

echo "Выполнение всех пунктов лабораторной работы успешно автоматизировано!"
