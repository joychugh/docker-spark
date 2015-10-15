# spark-docker
Docker Repo for Spark Deploy

## Usage
* Build all the images 
  * `make build`
* Start Master
  * `make start-master`
* Start Worker with given name
  * `make start-worker WORKER_NAME=WORKER1`
  * `make start-worker WORKER_NAME=WORKER2`
  *  ...
* Stop Master
  * `make stop-master`
* Stop Worker with given name
  * `make stop-worker WORKER_NAME=WORKER1`
  * `make stop-worker WORKER_NAME=WORKER2`
...
