create table winequality(
    density float,
    alcohol float,
    citric_acid float, 
    residual_sugar float,
    pH float,
    "type" char,
    quality int
);
COPY winequality
  FROM '/data/winequality.csv'
  DELIMITER ','
  CSV HEADER
  NULL as 'NA';
