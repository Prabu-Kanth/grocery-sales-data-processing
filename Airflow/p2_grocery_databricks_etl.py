import pendulum

from airflow.sdk import DAG
from airflow.providers.databricks.operators.databricks import DatabricksRunNowOperator


with DAG(
    dag_id="p2_grocery_databricks_etl",
    schedule=None,
    start_date=pendulum.datetime(2026, 9, 3, tz="UTC"),
    catchup=False,
    tags=["p2-grocery", "databricks"],
) as dag:

    run_databricks_etl = DatabricksRunNowOperator(
        task_id="run_databricks_etl",
        databricks_conn_id="databricks_default",
        job_id=846904843955233,
        wait_for_termination=True,
    )
