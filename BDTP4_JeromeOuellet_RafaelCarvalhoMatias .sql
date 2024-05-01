CREATE DATABASE BDTP4JeromeRafael;

USE BDTP4JeromeRafael;

CREATE TABLE produit (
    pro_id INT PRIMARY KEY,
    pro_code CHAR(3),
    pro_nom VARCHAR(30),
    pro_qte INT,
    pro_prix DECIMAL(10,2)
);

SELECT * FROM produit;

INSERT INTO produit (pro_id, pro_code, pro_nom, pro_qte, pro_prix) 
VALUES
    (1001, 'CRA', 'Crayon Rouge', 5000, 1.23),
    (1002, 'CRA', 'Crayon Bleu', 8000, 1.25),
    (1003, 'CRA', 'Crayon Noir', 2000, 1.25),
    (1004, 'BOI', 'Boite 2B', 10000, 0.48),
    (1005, 'BOI', 'Boite 2H', 8000, 0.49);
    
SELECT 
    pro_code,
    MAX(pro_prix) AS prix_max,
    MIN(pro_prix) AS prix_min,
    AVG(pro_prix) AS prix_moyen,
    STD(pro_prix) AS ecart_type_prix,
    SUM(pro_qte) AS quantite_totale
FROM produit
GROUP BY pro_code
ORDER BY pro_code;

SELECT 
	pro_code as "Code produit",
    COUNT(pro_nom) as "nombre",
    format(AVG(pro_prix),2) as "Moyenne"
    FROM produit
    Group by pro_code
    Having COUNT(pro_nom) > 2
    Order by pro_code;


