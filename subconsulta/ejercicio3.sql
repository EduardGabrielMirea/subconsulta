/*
1. Muestra la descripción del artículo más caro (precio por unidad).
*/
select max(a.unit_price) 
from article a;


select a.description
from article a
where a.unit_price = (
			select max(a.unit_price)
			from article a
);

/*
2. Muestra la descripción de los artículos que se han pedido 2 o más veces.
*/


select a.description,count(od.article_id)as veces_articulo
from article a
right join order_detail od
on a.id = od.article_id
right join order_head oh
on od.order_id = oh.id
group by a.id;


select orders_articles.description
from (
  select a.description,count(od.article_id)as veces_articulo
	from article a
	right join order_detail od
	on a.id = od.article_id
	right join order_head oh
	on od.order_id = oh.id
	group by a.id
) as orders_articles
where orders_articles.veces_articulo >=2;


/*
3. Muestra los ids y la fecha de los pedidos en los que no se ha pedido el artículo más barato
*/

SELECT MIN(a.unit_price) as precio_minimo
FROM article a;

select od.order_id as lineas_de_pedido_articulo
from order_detail od
left join article a
on od.article_id = a.id;

SELECT oh.id, oh.order_date
FROM order_head oh
WHERE oh.id NOT IN (
    SELECT od.order_id
    FROM order_detail od
    left JOIN article a 
  	ON od.article_id = a.id
    WHERE a.unit_price = (
        SELECT MIN(unit_price)
        FROM article
    )
);
