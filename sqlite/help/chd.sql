create table tdate(
	fini varchar(5) check(strftime('%H:%M',fini) < strftime('%H:%M',ffin)),
	ffin varchar(5) check(strftime('%H:%M',ffin) > strftime('%H:%M',fini)));
