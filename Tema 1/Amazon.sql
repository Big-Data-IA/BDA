
/* Consulta para obtener el número de clientes que tiene mi BBDD*/
select Count(*) from Cliente

/* Cantidad de articulos que se han venido más de 49 unidades  */
select 
  a.nombre, 
  SUM(pt.cantidad) as cantidadTotalPedidos
from 
  PedidoArticulo as pt 
  join Articulo as a on pt.idarticulo = a.idarticulo 
group by a.nombre
having sum(pt.cantidad)>49

/* Quiero ver articulos que no están en ningún pedidido */
select 
  a.nombre 
from 
  Articulo as a 
  left join PedidoArticulo as pt on a.idArticulo = pt.idArticulo 
where 
  pt.idPedidoArticulo is null;

/* El producto que más se ha pedido */
select 
  a.nombre, 
  count(pt.idPedidoArticulo) as cantidadPedidos 
from 
  Articulo as a 
  join PedidoArticulo as pt on a.idArticulo = pt.idArticulo 
group by 
  a.nombre 
order by 
  cantidadPedidos desc 
limit 1

/* El importe que ha pagado cada cliente */
select c.nombre, SUM(pa.cantidad * a.precio) as importe
from Cliente as c 
join Pedido as p on p.idCliente=c.idCliente 
join PedidoArticulo as pa on pa.idPedido=p.idPedido
join Articulo a on a.idArticulo=pa.idArticulo
group by c.idCliente,c.nombre
