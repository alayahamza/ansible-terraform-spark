```console
spark-submit \
    --deploy-mode cluster \
    --master spark://$(hostname -I | awk '{print $1}'):7077\
    --num-executors 1 \
    --driver-memory 1G \
    --num-executors 1 \
    --executor-memory 1G \
    --executor-cores 1 \
    --class org.apache.spark.examples.SparkPi \
    /opt/spark/examples/jars/spark-examples*.jar  
```
