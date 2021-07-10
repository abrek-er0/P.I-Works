/*I've created getUrl function for this question. This function returns NVARCHAR(100)
First I've found starting index right after :// part. Then I reversed string and
found html element closing tag \'s position - 1. Finally I found substring
from starting index to end index.*/
create function getUrl  
(  
   @rawurl nchar(100) 
)
returns NVARCHAR(100)
as
begin 
	DECLARE @start_index INT;
    DECLARE @end_index INT;
	DECLARE @result nvarchar(100);
    SET @start_index = CHARINDEX('://', @rawurl) + 3;
    SET @end_index =  LEN(REVERSE(@rawurl)) - CHARINDEX('\', REVERSE(@rawurl));
    SET @result = SUBSTRING(@rawurl, @start_index, @end_index - @start_index);
    RETURN @result;
end  