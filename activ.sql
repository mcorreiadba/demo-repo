set linesize 135 pagesize 50000 echo off head off
select 'SID  |SERIAL|USERNAME  |OSUSER    |PROGRAM                        |STATUS  |LOGON_TIME          |LAST_ACTIVITY       |IDLE_TIME  '||chr(10)||
'-------------------------------------------------------------------------------------------------------------------------------------' " "
from dual
union all
select * from (
select lpad(sid,5)||'|'||
       lpad(serial#,6)||'|'||
       rpad(username,10)||'|'||
       rpad(nvl(osuser,' '),10)||'|'||
       rpad(nvl(program,' '),32)||'|'||
       rpad(status,8)||'|'||
       lpad(to_char(LOGON_TIME,'YYYY-MM-DD HH24:MI:SS'),20)||'|'||
       lpad(to_char(sysdate - LAST_CALL_ET/86400,'YYYY-MM-DD HH24:MI:SS'),20)||'| '||
        lpad(trunc(LAST_CALL_ET/86400),2,0)||' '||
        lpad(trunc((LAST_CALL_ET/86400-trunc(LAST_CALL_ET/86400))*24),2,0)||':'||
        lpad (trunc((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60),2,0)||':'||
        lpad(trunc(((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60-trunc((LAST_CALL_ET/3600-trunc(LAST_CALL_ET/3600))*60))*60),2,0)" "
from v$session
where   type='USER'
--        and LAST_CALL_ET > 0
	and username is not null
order by LAST_CALL_ET
)
union all
select '-------------------------------------------------------------------------------------------------------------------------------------' " "
from dual;
set head on
