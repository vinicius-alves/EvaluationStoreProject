with production_models as (
 select  t1.idmodel, 
  max(t3.name) as projectname 
  from mysql.mydb.prediction t0
  left join mysql.mydb.run t1
  on t0.idrun = t1.idrun
  left join mysql.mydb.model as t2
  on t1.idmodel = t2.idmodel
  left join mysql.mydb.project as t3 
  on t1.idproject = t3.idproject
  group by 1
)

, featureimportances_runs as (

  select distinct idrun  from mysql.mydb.featureimportance 

)

, runs_production_models as (
  select * from mysql.mydb.run
  where idmodel in (select idmodel from production_models)
  and idrun in (select idrun from featureimportances_runs)
)

, base_relations as (
  select * from (
    select *, row_number () over (partition by idmodel order by idrun desc ) as nrow  
    from runs_production_models
  )
  where nrow = 1
)

select t0.*,   t3.name as feature,t2.importance  from production_models as t0
left join base_relations as t1 
on t0.idmodel = t1.idmodel
left join mysql.mydb.featureimportance as t2 
on t1.idrun = t2.idrun
left join mysql.mydb.feature as t3 
on t2.idfeature = t3.idfeature
order by t0.idmodel, t2.importance desc
