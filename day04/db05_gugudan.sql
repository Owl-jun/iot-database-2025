
SELECT
	CONCAT(b.b, '*', a.a , '=' , b.b*a.a)	2단,
	CONCAT(c.c, '*', a.a , '=' , c.c*a.a)	3단,
	CONCAT(d.d, '*', a.a , '=' , d.d*a.a)	4단,
	CONCAT(e.e, '*', a.a , '=' , e.e*a.a)	5단,
	CONCAT(f.f, '*', a.a , '=' , f.f*a.a)	6단,
	CONCAT(g.g, '*', a.a , '=' , g.g*a.a)	7단,
	CONCAT(h.h, '*', a.a , '=' , h.h*a.a)	8단,
	CONCAT(i.i, '*', a.a , '=' , i.i*a.a)	9단
FROM
(
	SELECT 1 a UNION ALL
	SELECT 2 a UNION ALL
	SELECT 3 a UNION ALL
	SELECT 4 a UNION ALL
	SELECT 5 a UNION ALL
	SELECT 6 a UNION ALL
	SELECT 7 a UNION ALL
	SELECT 8 a UNION ALL
	SELECT 9 a
) a
CROSS JOIN
	(SELECT 2 b)	b,
	(SELECT 3 c)	c,
	(SELECT 4 d)	d,
	(SELECT 5 e)	e,
	(SELECT 6 f)	f,
	(SELECT 7 g)	g,
	(SELECT 8 h)	h,
	(SELECT 9 i)	i