-- Creación de la tabla ItemDailyStatus
CREATE TABLE ItemDailyStatus (
    item_id INT PRIMARY KEY,
    date DATE NOT NULL,
    price DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);


DELIMITER //
CREATE PROCEDURE PopulateItemDailyStatus()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE currentDate DATE;
    DECLARE itemId INT;
    DECLARE itemPrice DECIMAL(10, 2);
    DECLARE itemStatus VARCHAR(20);
    
    -- Obtener la fecha actual
    SET currentDate = CURDATE();
    
    -- Cursor para recorrer los ítems
    DECLARE curItems CURSOR FOR
        SELECT item_id, price, status
        FROM Item;
    
    -- Manejo de errores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Iniciar transacción
    START TRANSACTION;
    
    OPEN curItems;
    
    read_loop: LOOP
        FETCH curItems INTO itemId, itemPrice, itemStatus;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Insertar el estado actual del ítem en ItemDailyStatus
        INSERT INTO ItemDailyStatus (item_id, date, price, status)
        VALUES (itemId, currentDate, itemPrice, itemStatus)
        ON DUPLICATE KEY UPDATE
            date = currentDate,
            price = itemPrice,
            status = itemStatus;
    END LOOP;
    
    CLOSE curItems;
    
    -- Confirmar la transacción
    COMMIT;
    
END //
DELIMITER ;
