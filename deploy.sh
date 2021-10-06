docker build -t saritah/multi-client:latest -t saritah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t saritah/multi-server:latest -t saritah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t saritah/multi-worker:latest -t saritah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push saritah/multi-client:latest
docker push saritah/multi-server:latest
docker push saritah/multi-worker:latest

docker push saritah/multi-client:$SHA
docker push saritah/multi-server:$SHA
docker push saritah/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=saritah/multi-server:$SHA
kubectl set image deployments/client-deployment client=saritah/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=saritah/multi-worker:$SHA