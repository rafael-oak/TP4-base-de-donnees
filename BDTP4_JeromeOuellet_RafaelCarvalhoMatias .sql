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
update produit set pro_fou_id = 501;
update produit set pro_fou_id = 502 where pro_id = 1004;

select pro_nom as "Nom des produits", 
pro_prix as "Prix produits", 
fou_nom as "Nom des fournisseur"
from produit 
inner join fournisseur on pro_fou_id = fou_id
where pro_prix < 1;

select pro_nom as "Nom des produits", 
pro_prix as "Prix produits", 
fou_nom as "Nom des fournisseur"
from produit, fournisseur
where pro_fou_id = fou_id
and pro_prix < 1;


select * from produit;

INSERT INTO fournisseur (fou_id, fou_nom, fou_tel) VALUES (506, 'Naji (best prof ever)', '123456789');

INSERT INTO produit (pro_id, pro_code, pro_nom, pro_qte, pro_prix, pro_fou_id)
VALUES (1006, 'BOI', 'Boite 2C', 7000, 2.23, 506);

alter table produit drop foreign key fk_pro_fou_id;
alter table produit drop column pro_fou_id;

delete from produit where pro_id = 1006;

CREATE TABLE contact (
    pro_id INT,
    fou_id INT,
    PRIMARY KEY (pro_id, fou_id),
    FOREIGN KEY (pro_id) REFERENCES produit(pro_id),
    FOREIGN KEY (fou_id) REFERENCES fournisseur(fou_id)
);

INSERT INTO contact (pro_id, fou_id)
VALUES
    (1001, 501),
    (1002, 501),
    (1003, 501),
    (1004, 502),
    (1001, 503);
    

select p.pro_nom as 'Nom Produit', p.pro_prix as 'Prix produit', f.fou_nom as 'Nom des fournisseurs'
from produit p
inner join contact c on p.pro_id = c.pro_id
inner join fournisseur f on c.fou_id = f.fou_id
where pro_prix > 1;

select p.pro_nom as 'Nom Produit', p.pro_prix as 'Prix produit', f.fou_nom as 'Nom des fournisseurs'
from produit p, contact c, fournisseur f
where p.pro_id = c.pro_id and f.fou_id = c.fou_id and pro_prix > 1;


select p.pro_code as 'Categorie produit', f.fou_nom as 'nom fournisseur', count(*) as nombre
from produit p, fournisseur f, contact c
where f.fou_id = c.fou_id and p.pro_id = c.pro_id
group by p.pro_code, f.fou_nom
order by p.pro_code, nombre desc;



select p.pro_code as 'Categorie produit', f.fou_nom as 'nom fournisseur', count(*) as nombre
from produit p, fournisseur f, contact c
where f.fou_id = c.fou_id and p.pro_id = c.pro_id
group by p.pro_code, f.fou_nom
having count(*) > 2
order by p.pro_code, nombre desc;

select fou_nom
from fournisseur
where fou_id not in (select fou_id from contact);

alter table produit add column pro_date_achat date;

UPDATE produit
SET pro_date_achat = '2024-02-25'
WHERE pro_id IN (1001, 1002, 1003);


UPDATE produit
SET pro_date_achat = '2024-04-10'
WHERE pro_id IN (1004, 1005);


select * from produit
where pro_date_achat between '2024-03-15' and (select curdate())
order by pro_id desc;

select pro_nom, pro_date_achat,DATEDIFF(CURDATE(), pro_date_achat) as 'nombre'
from produit
order by pro_date_achat desc;