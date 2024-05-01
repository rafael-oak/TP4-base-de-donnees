CREATE DATABASE BDTP4JeromeRafael;

USE BDTP4JeromeRafael;

CREATE TABLE produit (
    pro_id INT PRIMARY KEY NOT NULL,
    pro_code CHAR(3) NULL,
    pro_nom VARCHAR(30) NULL,
    pro_qte INT NULL,
    pro_prix DECIMAL(10,2) NULL
);

SELECT * FROM produit;

INSERT INTO produit (pro_id, pro_code, pro_nom, pro_qte, pro_prix) 
VALUES
    (1001, 'CRA', 'Crayon Rouge', 5000, 1.23),
    (1002, 'CRA', 'Crayon Bleu', 8000, 1.25),
    (1003, 'CRA', 'Crayon Noir', 2000, 1.25),
    (1004, 'BOI', 'Boite 2B', 10000, 0.48),
    (1005, 'BOI', 'Boite 2H', 8000, 0.49);
  
  -- EX 4
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

-- EX 5
SELECT 
	pro_code as "Code produit",
    COUNT(pro_nom) as "nombre",
    format(AVG(pro_prix),2) as "Moyenne"
    FROM produit
    Group by pro_code
    Having COUNT(pro_nom) > 2
    Order by pro_code;
    
-- EX 6
SET AUTOCOMMIT = 0;
SET SQL_SAFE_UPDATES = 0; 
UPDATE produit
SET pro_qte = pro_qte + 50, 
	pro_prix = pro_prix + 1.23 
    WHERE pro_nom = "Crayon Rouge";
COMMIT;

select * from produit;
 
-- EX 7
Set autocommit = 0;
Delete From produit
where pro_nom like "Crayon%";
select * from produit;	

ROLLBACK;
select * from produit;	
-- EX 8
CREATE TABLE fournisseur (
	fou_id INT primary key NOT NULL,
    fou_nom varchar(30) NULL,
    fou_tel CHAR(10) NULL
);
-- EX 9
insert INTO fournisseur (fou_id, fou_nom, fou_tel) VALUES
(501, "ABC Vente", 4181112222),
(502, "XYZ Compagnie", 5143334444),
(503, "QQ Coop", 6131118888),
(504, "QU Quebec", 4185557777);


-- EX 10
ALTER TABLE produit ADD COLUMN pro_fou_id INT, ADD CONSTRAINT fk_pro_fou_id foreign key (pro_fou_id) REFERENCES fournisseur (fou_id);
SELECT * FROM produit;
update produit set pro_fou_id = 501;














