
WbVarDef expression='pipedrive.persons';

WITH t1 AS
(
  SELECT userid,
         xid,
         TEXT ilike '%$[expression]%' AS is_match
  FROM SVL_STATEMENTTEXT
  GROUP BY userid,
           xid
)
SELECT t2.userid,
       t2.xid,
       t2.sequence,
       t2.starttime,
       t2.text,
       t1.is_match
FROM t1
  LEFT JOIN SVL_STATEMENTTEXT t2
         ON t1.userid = t2.userid
        AND t1.xid = t2.xid
WHERE t1.is_match
AND   t1.is_pipedrive_hr_persons = 0
AND   t1.is_pipedrive_persons = 1
ORDER BY t2.xid,
         t2.sequence;

