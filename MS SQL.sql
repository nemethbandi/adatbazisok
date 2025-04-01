create OR ALTER VIEW VSZOBA AS
select sz.*,
	  szh.SZALLAS_NEV,
      szh.HELY,
      szh.CSILLAGOK_SZAMA
from Szoba sz JOIN Szallashely szh ON sz.SZALLAS_FK = szh.SZALLAS_ID
SELECT * from VSZOBA



CREATE OR ALTER PROCEDURE SPUgyfelFoglalasok
@ugyfelazon nvarchar(40)
AS 
BEGIN
SELECT *
FROM Foglalas
WHERE ugyfel_fk = @ugyfelazon
END
EXEC SPUgyfelFoglalasok 'laszlo2'

CREATE OR ALTER FUNCTION UDFFerohely
(
  @fazon  INT 
)
RETURNS INT 
AS 
BEGIN
DECLARE @ferohely INT

 SELECT @ferohely = sz.FEROHELY
 FROM Foglalas f JOIN Szoba sz ON f.SZOBA_FK = sz.SZOBA_ID
 WHERE f.FOGLALAS_PK = @fazon

RETURN @ferohely
END
SELECT dbo.UDFFerohely(651)


