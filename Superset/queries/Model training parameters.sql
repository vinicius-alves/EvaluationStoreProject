with filter_training_run as (

  select * from mysql.mydb.tasktype
  where type = 'Training'

)


, base as (

  select * from (
    select t0.idrun, t0.idmodel, t3.name as project, 
    row_number() over(partition by idmodel order by t0.idrun desc) as nrow
    from mysql.mydb.run as t0 
    left join mysql.mydb.task as t1 
    on t0.idtask = t1.idtask
    inner join filter_training_run as t2 
    on t1.idtasktype = t2.idtasktype 
    left join mysql.mydb.project as t3 
    on t0.idproject = t3.idproject 
  ) where nrow = 1
)

select t0.idmodel, t0.project, t1.name as parameter ,t1.value
from base as t0 
left join mysql.mydb.parameter as t1
on t0.idrun = t1.idrun
order by t0.idmodel, parameter
